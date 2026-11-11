# J'Donuts App


## Requirement Analysis

- [ ] 10 screens
- [ ] offline first, fully offline
- [ ] clean architecture
- [ ] feature by feature

## 2026-11-11 Wed

- [ ] otp verify usecase
- [ ] login usecase 
- [ ] register usecase
- [ ] home page listing
- [ ] product detail
- [ ] reward , earn and gift listing 


as think of page flows,
there is not login / register

just enter phone number,
on verification of OTP, we will decide it has already registered or not and then where we go.

so use cases should be

- enter phone number , 
- enter otp , so return new / existing user , based on db
- enter name, dob and register
- home page listing
- reward page listing

we need to think as normal api integration.

what we can get back from posting phone number?

user_id , that's all.

on otp verification, we can send user_id and otp_code
what we can get from otp verification,
full user data (name, dob) or empty , since there is no data about user, 
so ask user to enter 
and then register,
register but with user id is already generated , or use phone as key indicator to update, not insert 

great, let's implement this flow.

so usecase should be

- enter_phone
- otp_verify
- enter_user_date
- home_listing
- reward_listing


context.go replaces the stack
let's push 

## What we do first.

- [ ] data structure

let's define main entities


### User

- id
- first name
- last name
- dob
- phone
- current_points
- member_id

### Member

- id
- name
- description
- image_url
- member_point

### Reward

- id
- name
- color_code
- reward_points

### Earn

- id
- product_id
- quantity
- earn_points

### Gift

- id
- name
- description
- image_url
- gift_points

### Product

- id
- name
- image_url
- priority_no
- price
- currency
- product_code
- description
- is_new
- discount_percentage
- discount_amount
- product_type_id

### Banners 

- id
- name
- image_url

### Shops

- id
- name
- description
- address
- image_url
- lat
- lng

### Product Type

- id
- name
- image_url
- priority_no

### Category

- id
- name
- image_url
- priority_no
- is_active

### Category Product

- id
- category_id
- product_id

### Cart

- id
- user_id
- shop_id
- product_id
- quantity

### Order

- id
- user_id
- shop_id
- status

### Order Item

- id
- order_id
- product_id
- quantity

### Feature List

- [ ] User login / register with phone no. along with OTP (6) digits ( default  123456 )

### Screen List

- [ ] Onboarding


## Current Check List

- [x] let's add packages
- [x] Directory Structure
- [x] Entity

dart run build_runner build --delete-conflicting-outputs

so we are done with domain and data
let's integrate login feature in ui.

so basic data flow is completed.

- [ ] add error handling
- [ ] အချိန် ရရင် deeplink ထည့် သက်ဆိုင်ရာ donuts ကို ရောက်အောင်။
- [ ] home page နဲ့ product အကြောင်း ဆက်သွားမယ်။

မနက်ဖြန် အချိန် (၆) နာရီ ဆက်ယူ။



### Packages

get_it
equatable
dartz
cached_network_image
riverpod
drift
json_annotation
go_router

drift_flutter
path_provider


flutter pub add get_it equatable dartz cached_network_image drift riverpod
flutter pub add go_router
flutter pub add drift_flutter path_provider


dev_dependencies
json_annotation
build_runner
json_serializable
drift_dev

flutter pub add --dev drift_dev build_runner json_serializable
flutter pub add --dev drift_dev build_runner json_serializable

dart run build_runner build --delete-conflicting-outputs

flutter pub add "json_annotation:^4.12.0"
dart run build_runner build


