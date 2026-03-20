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

ActiveRecord::Schema[7.2].define(version: 2024_05_10_063027) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "applicant_details", force: :cascade do |t|
    t.string "pronouns", null: false
    t.string "country_of_origin", null: false
    t.string "country_of_application", null: false
    t.string "native_language", null: false
    t.string "linkedin_url", null: false
    t.text "tell_us_about_yourself", null: false
    t.string "current_address", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "marital_status", null: false
    t.index ["user_id"], name: "index_applicant_details_on_user_id", unique: true
  end

  create_table "applicant_education_records", force: :cascade do |t|
    t.string "degree_type", null: false
    t.string "institution_name", null: false
    t.string "concentration", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.boolean "graduated", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "applicant_skills", force: :cascade do |t|
    t.text "description", null: false
    t.string "proficiency_level", null: false
    t.string "skill_type", null: false
    t.string "certification", null: false
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "applicant_work_experiences", force: :cascade do |t|
    t.string "company", null: false
    t.string "job_title", null: false
    t.text "responsibilities", null: false
    t.string "tenure", null: false
    t.string "location", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_applicant_work_experiences_on_user_id"
  end

  create_table "assertiveness_assessments", force: :cascade do |t|
    t.boolean "is_competitive", null: false
    t.boolean "is_decisive", null: false
    t.boolean "is_to_the_point", null: false
    t.boolean "is_impatient", null: false
    t.boolean "is_bold", null: false
    t.boolean "is_confronting", null: false
    t.boolean "is_challenging", null: false
    t.boolean "is_forthright", null: false
    t.boolean "is_fast_paced", null: false
    t.boolean "is_outspoken", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "business_models", force: :cascade do |t|
    t.string "key_partners"
    t.string "key_activities"
    t.string "value_proposition"
    t.string "customer_relationships"
    t.string "customer_segments"
    t.string "key_resources"
    t.string "channels"
    t.string "cost_structure"
    t.string "revenue_streams"
    t.string "strengths"
    t.string "opportunities"
    t.string "weaknesses"
    t.string "threats"
    t.string "new_entrants_threat"
    t.string "buyers_bargaining_power"
    t.string "suppliers_bargaining_power"
    t.string "substitute_products_or_services_threat"
    t.string "rivalry_among_existing_competitors"
    t.string "business_name_and_location"
    t.string "mission_and_vision_statement"
    t.string "products_or_service_overview"
    t.string "objectives_summary"
    t.string "market_brief_overview"
    t.string "business_nature"
    t.string "legal_structure"
    t.string "business_history"
    t.string "industry_background"
    t.string "products_or_services_description"
    t.string "unique_selling_point"
    t.string "pricing_strategy"
    t.string "lifecycle"
    t.string "research_and_development"
    t.string "target_market"
    t.string "market_size"
    t.string "market_trends"
    t.string "market_share"
    t.string "customer_preference"
    t.string "competitor_analysis"
    t.string "marketing_strategy"
    t.string "sales_model"
    t.string "sales_tactics"
    t.string "sales_structure"
    t.string "sales_activities"
    t.string "management_overview"
    t.string "organizational_structure"
    t.string "responsibilities"
    t.string "ownership"
    t.string "advisory"
    t.string "supply_chain"
    t.string "production_workflow"
    t.string "facilities"
    t.string "technology"
    t.string "quality_control"
    t.string "start_up_capital"
    t.string "budgets"
    t.string "revenue_generation_timeline"
    t.string "startup_fees"
    t.string "marketing_approach"
    t.string "hiring_strategy"
    t.string "marketing_contractors"
    t.string "milestone_timeline"
    t.string "pricing_structure"
    t.string "ip_protection"
    t.string "target_audience"
    t.string "sales_anticipation"
    t.string "break_even_point"
    t.string "ownership_structure"
    t.string "hiring_forecast"
    t.string "management_compensation"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "suv_application_id"
    t.index ["suv_application_id"], name: "index_business_models_on_suv_application_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "conversation_id", null: false
    t.bigint "user_id", null: false
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["conversation_id"], name: "index_comments_on_conversation_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "conversations", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "help_requests", force: :cascade do |t|
    t.text "details", null: false
    t.bigint "suv_application_id", null: false
    t.bigint "conversation_id", null: false
    t.bigint "admin_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "module_name"
    t.string "module_section"
    t.index ["admin_id"], name: "index_help_requests_on_admin_id"
    t.index ["conversation_id"], name: "index_help_requests_on_conversation_id"
    t.index ["suv_application_id"], name: "index_help_requests_on_suv_application_id"
  end

  create_table "home_carousels", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "immigration_modules", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "current_immigration_quiz_id"
    t.index ["current_immigration_quiz_id"], name: "index_immigration_modules_on_current_immigration_quiz_id"
  end

  create_table "immigration_quizzes", force: :cascade do |t|
    t.string "tech_hub_city"
    t.string "primary_purpose_for_sin"
    t.string "responsible_for_driving_license"
    t.string "ahcip_health_coverage"
    t.string "waiting_period_for_health_coverage"
    t.string "renowned_blue_nose_marathon"
    t.string "known_university_for_stem_program"
    t.string "vancouver_city_province"
    t.string "responsible_for_monetary_policy"
    t.string "income_tax_filing_deadline"
    t.string "quebec_g_license_equivalent"
    t.string "sin_issuance_facilitator"
    t.string "known_for_cowboy_culture"
    t.string "ubc_citys_location"
    t.string "insurance_option_for_newcomer"
    t.string "french_speaking_province"
    t.string "not_part_of_stem_field"
    t.string "offers_ohip_health_coverage"
    t.string "not_major_tech_hub"
    t.string "employability_step"
    t.string "apartment_leasing_requirement"
    t.string "driving_license_without_inexperienced_driver"
    t.string "post_primary_school_education"
    t.string "not_tip_for_newcomer"
    t.string "tax_collection_administration"
    t.string "ged_education_significance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "immigration_module_id"
    t.index ["immigration_module_id"], name: "index_immigration_quizzes_on_immigration_module_id"
  end

  create_table "inquiries", force: :cascade do |t|
    t.text "business_idea"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "reason_for_interest"
    t.string "where_did_you_hear_about_us"
    t.string "startup_location"
    t.string "status", null: false
    t.text "area_of_expertise", array: true
    t.text "which_industries_excite_you", array: true
    t.string "strengths"
    t.string "weaknesses"
    t.string "problem_to_solve"
    t.string "position"
    t.boolean "company_founder", null: false
    t.string "founders_count"
    t.string "founders_connection"
    t.string "team_members_info"
    t.string "business_industry"
    t.string "idea_description"
    t.string "unique_selling_proposition"
    t.string "problem_solved"
    t.string "solution_users"
    t.string "product_description"
    t.string "main_features"
    t.string "money_to_invest"
    t.string "innovation_description"
    t.string "partner_investment"
    t.string "competitors"
    t.string "revenue_source"
    t.string "business_stage"
    t.string "target_customers"
    t.boolean "existing_business_idea", null: false
    t.boolean "submission_confirmed", null: false
    t.date "submission_date"
    t.string "submission_full_name"
    t.string "other_business_industry"
    t.bigint "suv_application_id"
    t.string "decline_reason"
    t.index ["suv_application_id"], name: "index_inquiries_on_suv_application_id", unique: true
  end

  create_table "mentor_request_mentors", force: :cascade do |t|
    t.bigint "mentor_request_id", null: false
    t.bigint "mentor_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mentor_id"], name: "index_mentor_request_mentors_on_mentor_id"
    t.index ["mentor_request_id"], name: "index_mentor_request_mentors_on_mentor_request_id"
  end

  create_table "mentor_requests", force: :cascade do |t|
    t.bigint "suv_application_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "conversation_id", null: false
    t.index ["conversation_id"], name: "index_mentor_requests_on_conversation_id"
    t.index ["suv_application_id"], name: "index_mentor_requests_on_suv_application_id", unique: true
  end

  create_table "refining_your_idea_modules", force: :cascade do |t|
    t.string "idea_description"
    t.string "personal_passion"
    t.string "target_audience"
    t.string "product_service_address"
    t.string "market_gaps"
    t.string "potential_user_feedback"
    t.string "technical_financial_feasibility"
    t.string "scalability"
    t.string "flexibility"
    t.string "mission_statement"
    t.string "vision_statement"
    t.string "values"
    t.string "value_proposition"
    t.string "stage"
    t.string "other_stage"
    t.string "short_term_goal_1"
    t.string "short_term_goal_2"
    t.string "short_term_goal_3"
    t.string "short_term_goal_4"
    t.string "short_term_goal_5"
    t.string "short_term_goal_6"
    t.string "short_term_goal_7"
    t.string "short_term_goal_8"
    t.string "short_term_goal_9"
    t.string "short_term_goal_10"
    t.string "long_term_goal_1"
    t.string "long_term_goal_2"
    t.string "long_term_goal_3"
    t.string "long_term_goal_4"
    t.string "long_term_goal_5"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resources", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "application_module", null: false
  end

  create_table "responsiveness_assessments", force: :cascade do |t|
    t.boolean "is_open", null: false
    t.boolean "is_approachable", null: false
    t.boolean "is_outgoing", null: false
    t.boolean "is_intuitive", null: false
    t.boolean "is_informal", null: false
    t.boolean "is_warm", null: false
    t.boolean "is_casual", null: false
    t.boolean "is_animated", null: false
    t.boolean "is_random", null: false
    t.boolean "is_unstructured", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "simple_captcha_data", id: :serial, force: :cascade do |t|
    t.string "key", limit: 40
    t.string "value", limit: 6
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["key"], name: "idx_key"
  end

  create_table "skipped_steps", force: :cascade do |t|
    t.bigint "suv_application_id"
    t.bigint "user_id"
    t.string "step_name", null: false
    t.string "module_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["suv_application_id"], name: "index_skipped_steps_on_suv_application_id"
    t.index ["user_id"], name: "index_skipped_steps_on_user_id"
  end

  create_table "suv_applications", force: :cascade do |t|
    t.string "team_name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["team_name"], name: "index_suv_applications_on_team_name", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "phone"
    t.date "date_of_birth"
    t.boolean "account_active", null: false
    t.string "invitation_token"
    t.datetime "invitation_created_at"
    t.datetime "invitation_sent_at"
    t.datetime "invitation_accepted_at"
    t.integer "invitation_limit"
    t.string "invited_by_type"
    t.bigint "invited_by_id"
    t.integer "invitations_count"
    t.bigint "assertiveness_assessment_id"
    t.bigint "responsiveness_assessment_id"
    t.bigint "immigration_module_id"
    t.bigint "refining_your_idea_module_id"
    t.bigint "suv_application_id"
    t.datetime "last_activity_at"
    t.index ["assertiveness_assessment_id"], name: "index_users_on_assertiveness_assessment_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["immigration_module_id"], name: "index_users_on_immigration_module_id"
    t.index ["invitation_token"], name: "index_users_on_invitation_token", unique: true
    t.index ["invited_by_id"], name: "index_users_on_invited_by_id"
    t.index ["invited_by_type", "invited_by_id"], name: "index_users_on_invited_by"
    t.index ["refining_your_idea_module_id"], name: "index_users_on_refining_your_idea_module_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["responsiveness_assessment_id"], name: "index_users_on_responsiveness_assessment_id"
    t.index ["suv_application_id"], name: "index_users_on_suv_application_id"
    t.check_constraint "role::text <> 'applicant'::text OR invited_by_id IS NOT NULL OR invitation_accepted_at IS NULL OR (invited_by_id IS NOT NULL OR invitation_accepted_at IS NOT NULL) AND phone IS NOT NULL AND date_of_birth IS NOT NULL"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "applicant_details", "users"
  add_foreign_key "applicant_work_experiences", "users"
  add_foreign_key "comments", "conversations"
  add_foreign_key "comments", "users"
  add_foreign_key "help_requests", "conversations"
  add_foreign_key "help_requests", "suv_applications"
  add_foreign_key "help_requests", "users", column: "admin_id"
  add_foreign_key "immigration_modules", "immigration_quizzes", column: "current_immigration_quiz_id"
  add_foreign_key "immigration_quizzes", "immigration_modules"
  add_foreign_key "mentor_request_mentors", "mentor_requests"
  add_foreign_key "mentor_request_mentors", "users", column: "mentor_id"
  add_foreign_key "mentor_requests", "conversations"
  add_foreign_key "mentor_requests", "suv_applications"
  add_foreign_key "skipped_steps", "suv_applications"
  add_foreign_key "skipped_steps", "users"
  add_foreign_key "users", "assertiveness_assessments"
  add_foreign_key "users", "immigration_modules"
  add_foreign_key "users", "refining_your_idea_modules"
  add_foreign_key "users", "responsiveness_assessments"
end
