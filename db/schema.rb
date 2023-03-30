# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_10_15_231232) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "time_flow_monitor_id"
    t.string "alert_condition"
    t.string "alert_condition_value"
    t.index ["project_id"], name: "index_alerts_on_project_id"
  end

  create_table "event_stream_fields", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "event_stream_id", null: false
    t.string "data_type"
    t.string "stream_type"
    t.boolean "required"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "value"
    t.index ["event_stream_id"], name: "index_event_stream_fields_on_event_stream_id"
  end

  create_table "event_streams", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_event_streams_on_project_id"
  end

  create_table "monitor_fields", force: :cascade do |t|
    t.jsonb "definitions"
    t.bigint "time_flow_monitor_id", null: false
    t.bigint "time_window_id", null: false
    t.bigint "event_stream_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["event_stream_id"], name: "index_monitor_fields_on_event_stream_id"
    t.index ["time_flow_monitor_id"], name: "index_monitor_fields_on_time_flow_monitor_id"
    t.index ["time_window_id"], name: "index_monitor_fields_on_time_window_id"
  end

  create_table "organisations", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "projects", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "organisation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["organisation_id"], name: "index_projects_on_organisation_id"
  end

  create_table "report_items", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "report_id", null: false
    t.integer "report_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "event_stream_id"
    t.integer "duration"
    t.string "time_period"
    t.jsonb "data", default: {}, null: false
    t.boolean "aggregate", default: false
    t.index ["data"], name: "index_report_items_on_data", using: :gin
    t.index ["event_stream_id"], name: "index_report_items_on_event_stream_id"
    t.index ["report_id"], name: "index_report_items_on_report_id"
  end

  create_table "reports", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "project_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["project_id"], name: "index_reports_on_project_id"
  end

  create_table "simulation_fields", force: :cascade do |t|
    t.string "step_name"
    t.jsonb "event_definitions"
    t.integer "delay_type"
    t.integer "delay_value"
    t.integer "position"
    t.boolean "regular_expression", default: false
    t.bigint "simulation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "event_stream_id"
    t.index ["event_stream_id"], name: "index_simulation_fields_on_event_stream_id"
    t.index ["simulation_id"], name: "index_simulation_fields_on_simulation_id"
  end

  create_table "simulation_steps", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "sm_type"
    t.bigint "simulation_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["simulation_id"], name: "index_simulation_steps_on_simulation_id"
  end

  create_table "simulations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "replica"
    t.integer "simulation_type"
    t.string "value"
    t.string "sidekiq_job_id"
    t.index ["project_id"], name: "index_simulations_on_project_id"
  end

  create_table "time_flow_logs", force: :cascade do |t|
    t.string "title"
    t.integer "simulation_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "project_id"
    t.index ["simulation_id"], name: "index_time_flow_logs_on_simulation_id"
  end

  create_table "time_flow_monitors", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.bigint "project_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "sidekiq_job_id"
    t.index ["project_id"], name: "index_time_flow_monitors_on_project_id"
  end

  create_table "time_windows", force: :cascade do |t|
    t.integer "direction"
    t.integer "unit"
    t.integer "duration"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "organisation_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "alerts", "projects"
  add_foreign_key "event_stream_fields", "event_streams"
  add_foreign_key "monitor_fields", "event_streams"
  add_foreign_key "monitor_fields", "time_flow_monitors"
  add_foreign_key "monitor_fields", "time_windows"
  add_foreign_key "projects", "organisations"
  add_foreign_key "report_items", "reports"
  add_foreign_key "simulation_fields", "simulations"
  add_foreign_key "simulation_steps", "simulations"
  add_foreign_key "simulations", "projects"
  add_foreign_key "time_flow_logs", "simulations"
  add_foreign_key "time_flow_monitors", "projects"
end
