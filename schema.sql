Table clinics {
  id int [pk, increment]
  name varchar
  address text
  city varchar
  state varchar
  pincode varchar
  created_at timestamp
}

Table users {
  id int [pk, increment]
  full_name varchar
  mobile_number varchar [unique]
  email varchar [unique]
  password_hash varchar
  role varchar // patient, doctor, admin, support
  is_active boolean
  created_at timestamp
  updated_at timestamp
}

Table patients {
  id int [pk, increment]
  user_id int [ref: > users.id]
  full_name varchar
  age int
  gender varchar
  dob date
  blood_group varchar
  allergies text
  chronic_conditions text
  emergency_contact varchar
  created_at timestamp
}

Table doctors {
  id int [pk, increment]
  user_id int [ref: > users.id]
  clinic_id int [ref: > clinics.id]
  full_name varchar
  specialization varchar
  qualification varchar
  experience_years int
  fee decimal
  rating decimal
  bio text
  created_at timestamp
}

Table availability {
  id int [pk, increment]
  doctor_id int [ref: > doctors.id]
  day_of_week varchar
  start_time time
  end_time time
  slot_duration_minutes int
  break_start time
  break_end time
}

Table time_slots {
  id int [pk, increment]
  doctor_id int [ref: > doctors.id]
  availability_id int [ref: > availability.id]
  slot_date date
  start_time time
  end_time time
  is_booked boolean
  booking_locked_until timestamp
}

Table appointments {
  id int [pk, increment]
  patient_id int [ref: > patients.id]
  doctor_id int [ref: > doctors.id]
  clinic_id int [ref: > clinics.id]
  slot_id int [ref: > time_slots.id]
  appointment_type varchar // online, offline, followup
  status varchar // pending, confirmed, completed, cancelled, no_show, rescheduled
  token_number int
  consultation_type varchar
  symptoms text
  notes text
  booked_by_user_id int [ref: > users.id]
  created_at timestamp
  updated_at timestamp
}

Table appointment_reschedule_history {
  id int [pk, increment]
  appointment_id int [ref: > appointments.id]
  old_slot_id int [ref: > time_slots.id]
  new_slot_id int [ref: > time_slots.id]
  reason text
  requested_by int [ref: > users.id]
  status varchar
  created_at timestamp
}

Table payments {
  id int [pk, increment]
  appointment_id int [ref: > appointments.id]
  amount decimal
  currency varchar
  payment_method varchar
  transaction_ref varchar
  status varchar // initiated, success, failed, refunded
  paid_at timestamp
}

Table chats {
  id int [pk, increment]
  appointment_id int [ref: > appointments.id]
  sender_user_id int [ref: > users.id]
  message text
  attachment_url varchar
  created_at timestamp
  is_read boolean
}

Table feedback {
  id int [pk, increment]
  appointment_id int [ref: > appointments.id]
  doctor_rating int
  clinic_rating int
  waiting_experience_rating int
  comments text
  created_at timestamp
}

Table notifications {
  id int [pk, increment]
  user_id int [ref: > users.id]
  appointment_id int [ref: > appointments.id]
  type varchar // booking, reminder, cancel, reschedule
  title varchar
  message text
  status varchar // sent, delivered, read
  created_at timestamp
}

Table support_tickets {
  id int [pk, increment]
  user_id int [ref: > users.id]
  appointment_id int [ref: > appointments.id]
  issue_type varchar
  message text
  status varchar
  priority varchar
  created_at timestamp
}

Table family_mapping {
  id int [pk, increment]
  user_id int [ref: > users.id]
  patient_id int [ref: > patients.id]
  relation varchar
  is_primary boolean
}

Table groups {
  id int [pk, increment]
  doctor_id int [ref: > doctors.id]
  topic varchar
  created_at timestamp
}

Table group_members {
  id int [pk, increment]
  group_id int [ref: > groups.id]
  patient_id int [ref: > patients.id]
  joined_at timestamp
}

Table ivr_appointments {
  id int [pk, increment]
  user_id int [ref: > users.id]
  doctor_id int [ref: > doctors.id]
  external_reference varchar
  call_status varchar
  appointment_status varchar
  created_at timestamp
}
