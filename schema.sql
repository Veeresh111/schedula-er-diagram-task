Table users {
  user_id int [pk, increment]
  full_name varchar
  email varchar [unique]
  password_hash varchar
  phone varchar
  role varchar // patient, doctor, admin
  created_at timestamp
}

Table doctors {
  doctor_id int [pk, increment]
  user_id int [ref: > users.user_id]
  specialization varchar
  experience_years int
  hospital_name varchar
  consultation_fee decimal
  bio text
  rating decimal
}

Table patients {
  patient_id int [pk, increment]
  user_id int [ref: > users.user_id]
  age int
  gender varchar
  blood_group varchar
  medical_history text
  emergency_contact varchar
}

Table time_slots {
  slot_id int [pk, increment]
  doctor_id int [ref: > doctors.doctor_id]
  slot_date date
  start_time time
  end_time time
  is_booked boolean
}

Table appointments {
  appointment_id int [pk, increment]
  patient_id int [ref: > patients.patient_id]
  doctor_id int [ref: > doctors.doctor_id]
  slot_id int [ref: > time_slots.slot_id]
  booking_reason text
  status varchar // pending, confirmed, cancelled, completed, rescheduled
  created_at timestamp
}

Table chat_messages {
  message_id int [pk, increment]
  appointment_id int [ref: > appointments.appointment_id]
  sender_user_id int [ref: > users.user_id]
  receiver_user_id int [ref: > users.user_id]
  message_text text
  sent_at timestamp
  is_read boolean
}

Table reschedule_requests {
  request_id int [pk, increment]
  appointment_id int [ref: > appointments.appointment_id]
  old_slot_id int [ref: > time_slots.slot_id]
  new_slot_id int [ref: > time_slots.slot_id]
  reason text
  status varchar // requested, approved, rejected
  requested_at timestamp
}

Ref: "doctors"."hospital_name" < "doctors"."consultation_fee"
