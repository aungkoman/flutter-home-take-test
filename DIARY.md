# J'Donuts App


## Requirement Analysis

- [ ] 10 screens
- [ ] offline first, fully offline
- [ ] clean architecture
- [ ] feature by feature


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
- [ ] Directory Structure
- [ ] Entity

dart run build_runner build --delete-conflicting-outputs

so we are done with domain and data
let's integrate login feature in ui.




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


