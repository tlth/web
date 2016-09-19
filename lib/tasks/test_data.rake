namespace :db do
  desc 'Create data for local testing'
  task(test_data: :environment) do
    # User will get a random password at creation
    admin = User.find_or_create_by!(email: 'administrator@tlth.se',
                                    name: 'Admin Adminsson',
                                    role: 'admin')

    # So we force reset
    admin.reset_password!('testtest','testtest')
    puts "=== Sign in to Admin User with: ==="
    puts "=== email: administrator@tlth.se ==="
    puts "=== pass: testtest ==="

    image = Image.create(image: File.open('spec/support/cover.jpg'))

    # Page
    page = Page.find_or_create_by!(title_sv: 'Heltidare',
                                   title_en: 'Sabbatical office',
                                   content_sv: 'Detta är den svenska sidan',
                                   content_en: 'This is an english page',
                                   slug: 'sabbatical-officers')
    page.update(image: image)

    # Contact form
    contact_form = ContactForm.find_or_initialize_by(page: page, user: admin, title: 'Kontakt')
    unless contact_form.persisted?
      contact_form.questions << Question.new(content: 'Vem är du?')
      contact_form.questions << Question.new(content: 'Vem är jag?')
      contact_form.save!
    end

    # NavItems
    # nav_item_type
    #   menu == 0
    #   page == 1
    #   link == 2


    # Creating a dropdown menu
    dropdown = NavItem.find_by(title_sv: 'Meny (fälls ner)',
                               title_en: 'Menu (dropdown)',
                               nav_item_type: 0)

    dropdown ||= NavItem.create!(title_sv: 'Meny (fälls ner)',
                                 title_en: 'Menu (dropdown)',
                                 nav_item_type: :menu)

    # Creating a link below the dropdown
    nav_attr = { title_sv: 'Meny (länk)',
                 title_en: 'Menu (link)',
                 link: 'https://google.com',
                 parent: dropdown }

    unless NavItem.find_by(nav_attr.merge({ nav_item_type: 2 })).present?
      NavItem.create!(nav_attr.merge({ nav_item_type: :link }))
    end

    # Creating a page below the dropdown
    nav_attr = { title_sv: 'Meny (sida)',
                 title_en: 'Menu (page)',
                 page: page,
                 parent: dropdown }

    unless NavItem.find_by(nav_attr.merge({ nav_item_type: 1 })).present?
      NavItem.create!(nav_attr.merge({ nav_item_type: :page }))
    end


    # Post
    Post.find_or_create_by!(title_sv: 'En post',
                            title_en: 'A post',
                            content_sv: 'Detta är en post',
                            content_en: 'This ia a post')

    # Event
    Event.find_or_create_by!(title_sv: 'Ett evenemang',
                             title_en: 'An event',
                             description_sv: 'Detta är ett evenemang.',
                             description_en: 'This is an event.',
                             start_time: 2.hours.from_now,
                             end_time: 10.hours.from_now)

    # Tag
    Tag.find_or_create_by!(title: 'Näringsliv', color: '#eb7125')
    Tag.find_or_create_by!(title: 'Webbutveckling', color: '#ffffff')
  end
end
