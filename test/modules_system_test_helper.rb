# frozen_string_literal: true

module ModulesSystemTestHelper # rubocop:disable Metrics/ModuleLength
  def create_account
    click_link 'Inquire'

    fill_in_sign_up_details
    click_button 'Sign up'

    assert_text 'Welcome! You have signed up successfully.'
  end

  def complete_inquiry_module # rubocop:disable Metrics/MethodLength
    fill_in 'Team name', with: 'Vanguard'
    click_button 'Start Inquiry'
    fill_in_applicant_specific_steps(invite_other_applicant: true)

    using_session('other_applicants_session') do
      accept_applicant_invitation

      fill_in_applicant_specific_steps

      fill_in_additional_info

      click_link 'Continue'

      fill_in_your_interest

      click_link 'Continue'

      confirm_submission

      click_button 'Submit Inquiry'
    end
  end

  def assert_inquiry_submitted
    using_session('other_applicants_session') do
      assert_text 'Thank you for your submission'
    end

    Inquiry.last.approved!
  end

  def complete_quick_assessment_module
    click_link 'Modules'

    click_link 'Introduction'
    click_link 'Continue'

    fill_in_assertiveness_assessment
    click_save_step

    assert_text 'Assertiveness assessment was successfully updated.'

    fill_in_responsiveness_assessment
    click_save_step
  end

  def assert_quick_assessment_submitted
    assert_text 'Based on your replies we may suggest that the following social style better describes you:'

    click_link 'Back to modules'
  end

  def complete_immigration_module # rubocop:disable Metrics/MethodLength
    click_link 'Basic info'
    click_link 'Continue'

    click_link 'Startup', match: :first
    click_link 'Continue'

    click_link 'Legal', match: :first
    click_link 'Continue'

    click_link 'Housing'
    click_link 'Continue'

    click_link 'Education'
    click_link 'Continue'

    click_link 'Helpful tips'
    click_link 'Continue'

    click_link 'Final quiz'

    choose_right_answers

    click_button 'Save'
  end

  def assert_immigration_submitted
    assert_text 'Final quiz passed!'
  end

  def complete_refining_your_idea_module
    click_link 'Your idea'

    fill_in_my_idea

    click_button 'Save'

    fill_in_steps_after_my_idea

    fill_in_goals

    click_button 'Save'
  end

  def assert_refining_your_idea_submitted
    assert_text 'Module 2: Refine Your Idea complete!'
  end

  def complete_registration_documents_module
    click_link 'Register business'

    click_link 'Continue'

    attach_file 'Online registration document', 'test/fixtures/files/placeholder.jpeg'

    click_button 'Save'

    attach_file 'Bank account document', 'test/fixtures/files/placeholder.jpeg'

    click_button 'Save'
  end

  def assert_registration_documents_submitted
    assert_text 'Module 3: Legal, Taxation & Incorporation complete!'
  end

  def complete_business_model_module # rubocop:disable Metrics/MethodLength
    # click_button 'Business Model'
    #
    # click_link 'Getting started with business plan'

    click_link 'Continue'

    fill_in_business_model_canvas

    attach_file 'Share your learnings from the Business Model Canvas exercise!',
                'test/fixtures/files/placeholder.jpeg'

    fill_in_swot_analysis

    attach_file 'Share your learnings from the SWOT Analysis exercise!', 'test/fixtures/files/placeholder.jpeg'

    fill_in_porters_five_forces

    attach_file "Share your learnings from the PORTER's Five Forces exercise!", 'test/fixtures/files/placeholder.jpeg'

    click_button 'Save'

    fill_in_your_business_plan

    fill_in_additional_questions

    click_button 'Save', match: :first
  end

  def assert_business_model_submitted
    assert_text 'Module 7: The Business Model complete!'
  end

  private

  def fill_in_sign_up_details
    fill_in 'First name', with: 'Bob'
    fill_in 'Last name', with: 'Smith'
    fill_in 'Phone', with: '599 111111'
    fill_in 'Email', with: 'nole@test.com'
    fill_in 'Date of birth', with: '30/10/2000'
    fill_in 'Password', with: 'Password123'
    fill_in 'Password confirmation', with: 'Password123'
    fill_in 'captcha', with: SimpleCaptcha::SimpleCaptchaData.first.value
  end

  # Inquiry module methods

  def fill_in_applicant_details(country: 'Georgia')
    fill_in 'Pronouns', with: 'You'
    fill_in 'Country of origin', with: country
    fill_in 'Country of application', with: 'USA'
    fill_in 'Native language', with: 'Georgian'
    fill_in 'Linkedin url', with: 'https//zyx'
    fill_in 'Tell us about yourself', with: 'I am a great businessman.'
    fill_in 'Current address', with: '5A, Apartment 9, New-York, New Jersey, ZIP 11111'
    select 'Single', from: 'Marital status'
    label = 'Please attach the results of the language test from an approved agency if you have taken one.'
    attach_file label, 'test/fixtures/files/placeholder.jpeg'
  end

  def fill_in_applicant_education_record(option: 'Yes')
    fill_in 'Degree type', with: 'Graduate'
    fill_in 'Institution name', with: 'Oxford'
    fill_in 'Concentration', with: 'Economics - Mathematics'
    fill_in 'Start date', with: '2015-09-01'
    fill_in 'End date', with: '2017-09-01'
    choose option
  end

  def fill_in_applicant_work_experience(company: 'Amazon')
    fill_in 'Company', with: company
    fill_in 'Job title', with: 'Developer'
    fill_in 'Responsibilities', with: 'Create valid code'
    fill_in 'Tenure', with: 'Two years'
    fill_in 'Location', with: 'Washington'
  end

  def fill_in_applicant_skill(skill_type: 'Beginner')
    fill_in 'Description', with: 'Talking to sheep'
    select  'Expert', from: 'Proficiency level'
    fill_in 'Skill type', with: skill_type
    fill_in 'Certification', with: 'None'
  end

  def fill_in_applicant_specific_steps(invite_other_applicant: false) # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    fill_in_applicant_details
    click_button 'Save'

    assert_text 'Applicant detail was successfully created.'

    if invite_other_applicant
      click_link 'Add another applicant'

      assert_text 'Another applicant'
      fill_in 'First name', with: 'Jole'
      fill_in 'Last name', with: 'Barker'
      fill_in 'Email', with: 'jole@test.com'

      click_button 'Invite applicant'
    end

    click_link 'Continue'

    click_link 'New Applicant education record'
    fill_in_applicant_education_record
    click_button 'Create Applicant education record'

    click_link 'Continue'

    click_link 'New Applicant work experience'
    fill_in_applicant_work_experience
    click_button 'Create Applicant work experience'

    click_link 'Continue'

    click_link 'New Applicant skill'
    fill_in_applicant_skill
    click_button 'Create Applicant skill'

    click_link 'Continue'
  end

  def accept_applicant_invitation
    open_email('jole@test.com')
    current_email.click_link 'Accept invitation'
    fill_in 'Phone', with: '0123456789'
    fill_in 'Date of birth', with: 18.years.ago
    fill_in 'Password', with: 'password123'
    fill_in 'Password confirmation', with: 'password123'
    click_button 'Accept Invitation'
  end

  def fill_in_additional_info
    fill_in 'Why are you interested in Canadian Startup Program?', with: 'I am the next elon musk'
    fill_in 'Where did you hear about Aligned SUV Consultancy / Think8 Global Institute?', with: 'Google'
    fill_in 'Where in Canada do you wish to locate your Start-Up?', with: 'Toronto'
  end

  def fill_in_your_interest # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    if js?
      choose 'Yes'
      fill_in 'What is/will be your designation in the company?', with: 'director'
      choose 'Yes', match: :first
      fill_in 'How many founders does the company have?', with: 5
      fill_in 'If you are multiple founders, how did you get acquinted?', with: 'Chilhood friends'
      fill_in "Please list all team members' name, roles & responsibilities", with: 'too lazy to list all of them'
      select 'Other (please specify)', from: 'What is the industry the business/idea operates in?'
      fill_in 'Other business industry', with: 'Super blockchain'
      fill_in 'Describe the idea in 100 words or less', with: 'Undescribable'
      fill_in 'What is your value proposition or unique selling proposition?', with: 'Everyone needs extra help'
      fill_in 'What problem are you solving', with: 'People will get rid of mandane tasks'
      fill_in 'Who will benefit from the solution?', with: 'Rich'
      fill_in 'Who are your customers?', with: 'Factory owners'
      choose 'Idea'
      fill_in 'Describe the product or the service', with: 'Robots that help doing mandane tasks'
      fill_in 'Specify the minimum of 3 key features of the product or service', with: 'Fulfilling tasks'
      fill_in 'How much money are you willing to invest in this business?', with: '3 millions'
      fill_in 'How is the idea or business innovative?', with: 'It connected to AI'
      fill_in 'Are you looking for investment from partners, VC firms or angel investors? ' \
              '(If yes, specify type of investment)',
              with: 'Stocks'
      fill_in 'Have you looked into any competitors? Describe your competition', with: "They aren't many"
      fill_in 'How will the business/idea generate revenue?', with: 'Through sales'
    else
      select 'Mathematics', from: 'What is your area of expertise? (Choose up to 5)'
      select 'Transportation', from: 'Which industries excite you? (Choose up to 5)'
      fill_in 'What are your professional strengths?', with: 'Problem solving'
      fill_in 'What are your weaknesses?', with: 'I am perfect'
      fill_in 'Share at least one business idea that intrigues you?', with: 'Robotics'
      fill_in 'What are some problems you see around the world you want to solve? ' \
              'What is the biggest crisis facing humanity in your opinion?',
              with: 'Consumerism'

    end
    click_button 'Save'
  end

  def confirm_submission
    fill_in 'Sign date', with: Time.zone.today
    fill_in 'Full Name (as signature)', with: 'Bob Dole'

    # rubocop:disable Layout/LineLength
    check 'By submitting this form, I confirm that information I have provided is true, accurate and complete to the best of my knowledge. I also agree to update Aligned SUV Consultancy / Think8 Global Institute promptly if any of information changes.'
    # rubocop:enable Layout/LineLength
  end

  # Quick assessment methods

  def fill_in_assertiveness_assessment
    choose 'Competitive'
    choose 'Decisive'
    choose 'To the point'
    choose 'Impatient'
    choose 'Bold'
    choose 'Confronting'
    choose 'Challenging'
    choose 'Forthright'
    choose 'Fast-paced'
    choose 'Outspoken'
  end

  def click_save_step
    if js?
      click_link 'Continue'
    else
      click_button 'Save'
    end
  end

  def fill_in_responsiveness_assessment
    choose 'Open'
    choose 'Approachable'
    choose 'Outgoing'
    choose 'Intuitive'
    choose 'Informal'
    choose 'Warm'
    choose 'Casual'
    choose 'Animated'
    choose 'Random'
    choose 'Unstructured'
  end

  # Immigration module methods

  def choose_right_answers
    choose 'Toronto', match: :first
    choose 'Securing employment'
    choose 'DriveTest'
    choose 'Alberta', match: :first
    choose 'Three months'
    choose 'Nova Scotia'
    choose 'University of Toronto'
    choose 'Newfoundland and Labrador', match: :first
    choose 'Bank of Canada', match: :first
    choose 'April 30th'
  end

  # Refining your idea module methods

  def fill_in_my_idea # rubocop:disable Metrics/MethodLength
    fill_in 'Please state your idea in the below box in no more than 100 words:',
            with: 'An innovative solution to reduce food waste by connecting restaurants with local food banks.'
    fill_in 'Why are you pursuing this idea? What personal passion or problem are you trying to solve?',
            with: 'Passionate about environmental sustainability and reducing hunger.'
    fill_in 'Who is your target audience? Who faces the problem your idea seeks to solve?',
            with: 'Restaurants with surplus food, local food banks, communities in need.'
    fill_in 'How will your product/service address the needs of your audience?',
            with: 'Offer real-time food donation matching.'
    fill_in 'Identify existing gaps in the market & list them down.',
            with: 'Lack of efficient food redistribution.'
    fill_in 'Talk to one/more potential user. List down their feedback.',
            with: 'Positive response with suggestions for a mobile app for easier access.'
    fill_in 'Is the idea technically and financially feasible? List some technological barriers if any. Estimate the amount of money you will need to take the product to market.', # rubocop:disable Layout/LineLength
            with: 'Feasible with $50,000 initial funding.'
    fill_in 'Is your idea scalable?',
            with: 'Can scale with expansion.'
    fill_in 'Is your idea flexible? Can you pivot strategies quickly at any point of development?',
            with: 'Yes, flexible for strategy changes.'
  end

  def fill_in_steps_after_my_idea # rubocop:disable Metrics/MethodLength
    fill_in 'Mission statement',
            with: 'To bridge the gap between food surplus and scarcity, making our communities more sustainable.'
    click_button 'Save'

    fill_in 'Vision statement',
            with: 'A world where every surplus meal finds a plate, reducing food waste and hunger simultaneously.'
    click_button 'Save'

    fill_in 'Values',
            with: 'Sustainability, Community, Innovation, Respect, Integrity.'
    click_button 'Save'

    fill_in 'Value proposition',
            with: 'Connecting surplus to need, our platform ensures no meal goes to waste,
            serving our communities and planet.'
    click_button 'Save'
  end

  def fill_in_goals # rubocop:disable Metrics/MethodLength
    select 'Idea', from: 'Stage'
    fill_in 'Short term goal 1', with: 'Complete market research'
    fill_in 'Short term goal 2', with: 'Finalize business plan'
    fill_in 'Short term goal 3', with: 'Build MVP (Minimum Viable Product)'
    fill_in 'Short term goal 4', with: 'Secure initial funding'
    fill_in 'Short term goal 5', with: 'Assemble core team'
    fill_in 'Short term goal 6', with: 'Pilot in local community'
    fill_in 'Short term goal 7', with: 'Gather user feedback'
    fill_in 'Short term goal 8', with: 'Iterate on product based on feedback'
    fill_in 'Short term goal 9', with: 'Establish brand identity'
    fill_in 'Short term goal 10', with: 'Launch marketing campaign'

    fill_in 'Long term goal 1', with: 'National expansion'
    fill_in 'Long term goal 2', with: 'Partner with major food service providers'
    fill_in 'Long term goal 3', with: 'Expand product line'
    fill_in 'Long term goal 4', with: 'Achieve profitability'
    fill_in 'Long term goal 5', with: 'Explore international markets'
  end

  # Business model module methods

  def fill_in_business_model_canvas
    fill_in 'Key Partners', with: 'Third party sellers'
    fill_in 'Key Activities', with: 'E-commerce platform'
    fill_in 'Value Proposition', with: 'Wide product selection'
    fill_in 'Customer Relationships', with: 'Personalized shopping'
    fill_in 'Customer Segments', with: 'Individual online shopping'
    fill_in 'Key Resources', with: 'E-commerce platform'
    fill_in 'Channels', with: 'E-commerce website'
    fill_in 'Cost Structure', with: 'Fulfillment and shipping'
    fill_in 'Revenue Streams', with: 'Sale of products'
  end

  def fill_in_swot_analysis
    fill_in 'Strengths', with: 'Customer oriented'
    fill_in 'Opportunities', with: 'Personalized Health and Wellness Services'
    fill_in 'Weaknesses', with: 'Limited Brand Recognition'
    fill_in 'Threats', with: 'Competitive Pressure'
  end

  def fill_in_porters_five_forces
    fill_in 'Threat of New Entrants', with: 'Moderate'
    fill_in 'Bargaining Power of Suppliers', with: 'Low'
    fill_in 'Bargaining Power of Suppliers', with: 'Moderate'
    fill_in 'Threat of Substitute Products or Services', with: 'High'
    fill_in 'Rivalry Among Existing Competitors', with: 'Low'
  end

  def fill_in_your_business_plan # rubocop:disable Metrics/MethodLength, Metrics/AbcSize
    fill_in 'Business Name and Location:', with: 'GreenTech Solutions, headquartered in Delhi, India.'
    fill_in 'Mission and Vision Statements:', with: 'Revolutionize renewable energy for all.'
    fill_in 'Product or Service Overview:', with: 'Solar energy solutions for homes and businesses.'
    fill_in 'Summary of Objectives:', with: 'Expand market presence, increase sales by 20% annually.'
    fill_in 'Brief Market Overview:', with: 'Renewable energy market growing rapidly.'
    fill_in 'Nature of the Business:', with: 'Renewable energy provider.'
    fill_in 'Legal Structure:', with: 'Registered as LLC in California.'
    fill_in 'Business History:', with: 'Founded in 2015 by environmental engineers.'
    fill_in 'Description:', with: 'High-efficiency solar panels and systems.'
    fill_in 'Unique Selling Points:', with: 'Cutting-edge tech, personalized service.'
    fill_in 'Pricing Strategy:', with: 'Competitive pricing, flexible financing.'
    fill_in 'Lifecycle:', with: '25+ years lifespan.'
    fill_in 'R&D:', with: 'Continuous innovation.'
    fill_in 'Target Market:', with: 'Homes, businesses seeking sustainability.'
    fill_in 'Market Size:', with: 'Projected $223.3B by 2026.'
    fill_in 'Market Trends:', with: 'Rooftop solar, tech advancements, gov. incentives.'
    fill_in 'Market Share:', with: 'Capture significant regional share.'
    fill_in 'Customer Preferences:', with: 'Efficiency, reliability, sustainability.'
    fill_in 'Competitor Analysis:', with: 'Competitive landscape, startups.'
    fill_in 'Marketing Strategy:', with: 'Digital ads, social media, industry events.'
    fill_in 'Sales Model:', with: 'Direct sales, personalized solutions.'
    fill_in 'Sales Tactics:', with: 'Education, customized proposals.'
    fill_in 'Sales Structure:', with: 'Dedicated sales team.'
    fill_in 'Sales Activities:', with: 'Site assessments, proposals, negotiations.'
    fill_in 'Management Overview:', with: 'Experienced professionals.'
    fill_in 'Organizational Structure:', with: 'Flat hierarchy, clear communication.'
    fill_in 'Roles/Responsibilities:', with: 'Defined roles aligned with objectives.'
    fill_in 'Ownership:', with: 'Co-founders, investors.'
    fill_in 'Board/Advisory:', with: 'Industry experts, stakeholders.'
    fill_in 'Supply Chain:', with: 'Reputable suppliers.'
    fill_in 'Production Workflow:', with: 'Design, manufacturing, QC.'
    fill_in 'Facilities:', with: 'State-of-the-art production facility.'
    fill_in 'Equipment/Technology:', with: 'Cutting-edge machinery.'
    fill_in 'Quality Control:', with: 'Rigorous QC measures.'
    fill_in 'Start-up Capital:', with: '$5M initial funding.'
    fill_in 'Budgets:', with: 'R&D, marketing, operations, expansion.'
  end

  def fill_in_additional_questions # rubocop:disable Metrics/MethodLength
    fill_in 'When do you foresee your product/service becoming revenue-generating?', with: 'Within 12 months.'
    fill_in 'Will you have to pay any monthly/semi-annual/annual fees for your start-up? If so, what are they?',
            with: 'Yes, hosting and software subscriptions.'
    fill_in 'What\'s your approach to marketing and the channels you\'ll utilize to reach clients?',
            with: 'Digital marketing via social media, SEO, and email campaigns.'
    fill_in 'What is your hiring strategy? Is development going to be done in-house or outsourced?',
            with: 'Initially in-house, with plans to outsource for scalability.'
    fill_in 'Do you intend to employ staff or use contractors for your marketing activities?',
            with: 'Combination of in-house team and contracted specialists.'
    fill_in 'Share a timeline for your key milestone. (i.e. When will the solution or app be ready?)',
            with: 'Beta launch in 6 months, full launch in 12 months.'
    fill_in 'How have you structured your pricing and revenue sources? What are they?',
            with: 'Tiered subscription model, with additional revenue from ad placements.'
    fill_in 'Do you need to protect any Intellectual Property? If yes, how & when do you plan to get it done?',
            with: 'Yes, trademark and patent applications within 6 months.'
    fill_in 'Who are your primary target audience and clients? How do you intend to attract them?',
            with: 'Tech-savvy professionals aged 25-45; targeted ads and influencer partnerships.'
    fill_in 'When do you anticipate your company to start making sales?', with: 'Within 9 months of launch.'
    fill_in 'At what point do you predict the company will reach its break-even point?',
            with: 'Within 18-24 months post-launch.'
    fill_in 'How is ownership divided, and how much capital has each applicant invested?',
            with: '50% each; $100,000 from each applicant.'
    fill_in 'Can you share a 5-year hiring forecast based on your current projections?',
            with: '10 additional employees in year 1, doubling each subsequent year.'
    fill_in 'For the management team, will compensation be through dividends or set salaries?',
            with: 'Set salaries initially, with potential for dividends in profitable years.'
  end
end
