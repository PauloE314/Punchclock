require 'spec_helper'

feature 'Add new Punch' do
  let!(:authed_user) { create_logged_in_user }
  let!(:project) do
    Project.create(
      name: Faker::Internet.name, company_id: authed_user.company_id
    )
  end
  scenario 'creating punch' do
    visit '/punches/new'
    expect(page).to have_content I18n.t(
      :creating, scope: %i(helpers actions), model: Punch.model_name.human
    )

    within '#new_punch' do
      fill_in 'punch[from_time]', with: '08:00'
      fill_in 'punch[to_time]', with: '12:00'
      fill_in 'punch[when_day]', with: '2001-01-01'
      select project.name, from: 'punch[project_id]'
      click_button 'Criar Punch'
    end
    expect(page).to have_content('Punch foi criado com sucesso.')
  end
end
