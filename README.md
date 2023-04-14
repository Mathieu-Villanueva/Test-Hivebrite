# README

## Test prompts

Develop a functionality allowing administrators to customize:

- the User profile
- the User signup form
- an Event Registration form

In order to focus on the important parts, no need to develop a UI. The code will be run through the tests, and possibly through the console. We want to focus on models, possibly service classes with clean interfaces, but not controllers/views.

Use cases that the service must support:

- Admin manages the global User custom attributes
- Admin manages a specific Event’s custom attributes
- Admin makes a custom attribute optional/required on the User profile
- Admin makes a custom attribute optional/required on the User signup form
- Admin makes a custom attribute optional/required on a specific Event Registration form
- User fills in a custom attribute on his profile
- User fills in a custom attribute on the signup form
- User fills in a custom attribute on an Event Registration form
- User reads his custom attributes on his profile
- Admin reads an Event registration’s custom attributes

Custom attributes types supported:

- Text
- Boolean

## Description

This code allows to answer most of the prompts above.
This are the gems I used :

- FactoryBot : https://github.com/thoughtbot/factory_bot (to help with specs)
- Pundit : https://github.com/varvet/pundit (to help with authorizations)
- Reform:Form : https://trailblazer.to/2.1/docs/reform#reform-overview (to handle forms)
- ServiceActor : https://github.com/sunny/actor (to handle services)
- Rspec : for the specs

I didn't have the time to handle signin so i don't have a real current_user.
In the actors, current_user input is needed.

```
Users::UpdateEmail.call(
  current_user: 'The user to authorize',
  email: 'The email we want to update the user with',
  user: 'The user we want to update'
)
```

## Schema

Tables :

- Event
- User
- CustomAttribute
- GlobalAttribute

Global attributes are what defines the signup form.

- name :
- required : Determines if a user needs to provide a value for this global attribute
- active : Determines if a global attribute needs to appears on a user form (profile / signup)
- custom_attributes : This is the list of custom_attributes linked to this global and that are associated with a user

Custom attributes can be associated with a User OR an Event, which are refered as `customizable`.
They can also be linked to a global attribute

- name
- value
- required
- customizable
- global_attribute (is optional)

## How to use this code :

This code is meant to be use with actors, which are services, do perform actions

### Admin manages the global User custom attributes

This is possible with the actors in :
`app/actors/global_attributes`

An admin can :

- create a new global_attribute :

  ```ruby
    GlobalAttributes::Create.call(
      current_user: user_to_athorize,
      attribute_name: name_of_the_new_global,
      required: boolean
    )
  ```

- mark as optional :
  ```ruby
   GlobalAttributes::MarkAsOptional.call(
     current_user: user_to_athorize,
     attribute_name: name_of_the_new_global,
   )
  ```
- mark as required :
  ```ruby
   GlobalAttributes::MarkAsRequired.call(
     current_user: user_to_athorize,
     attribute_name: name_of_the_new_global,
   )
  ```
- mark as active :
  ```ruby
   GlobalAttributes::MarkAsActive.call(
     current_user: user_to_athorize,
     attribute_name: name_of_the_new_global,
   )
  ```
- mark as inactive :
  ```ruby
   GlobalAttributes::MarkAsInactive.call(
     current_user: user_to_athorize,
     attribute_name: name_of_the_new_global,
   )
  ```

### Admin manages a specific Event/User custom attribute :

An admin can :

- mark as required a custom attribute on a Event/User :

  ```ruby
    Customizables::MarkCustomAttributeAsRequired.call(
      current_user: use_to_authorize,
      customizable: event/user,
      attribute_name: name_of_the_custom_attribute
    )
  ```

- mark as optional a custom attribute on a Event/User :

  ```ruby
    Customizables::MarkCustomAttributeAsOptional.call(
      current_user: use_to_authorize,
      customizable: event/user,
      attribute_name: name_of_the_custom_attribute
    )
  ```

- create a new custom attribute for a specific Event/User :

  ```ruby
    Customizables::AddCustomAttribute.call(
      current_user: use_to_authorize,
      customizable: event/user,
      name: name_of_the_custom_attribute,
      required: boolean,
      value: value_of_the_custom_attribute
    )
  ```

- update the value for a custom attribute on a specific Event/User:
  ```ruby
    Customizables::UpdateCustomAttribute.call(
      attribute_name: attribute_name,
      customizable: event/user,
      new_value: value,
      current_user: current_user
    )
  ```

### User fills in a custom attribute on the signup form

This is accomplish by `Users::SignUp.call(params)`

`params` must have this shape :

```ruby
  {
    email: STRING,
    attributes: [
      { # global attribute
        name: STRING,
        value: STRING,
      },
      { # global attribute
        name: STRING,
        value: STRING,
      }
    ]
  }
```
