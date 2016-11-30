require 'rails_helper'

describe 'ArticlesOfClothing endpoints' do
  describe 'GET /article_of_clothings?category_id=<category_id>' do
    context 'with valid category id' do
      it 'returns the JSON for the existing articles of clothing' do
        user = create(:user)
        categories = create_list(:category, 2)

        articles = create_list(:article_of_clothing, 3, user: user, category: categories[0])
        articles_2 = create_list(:article_of_clothing, 3, user: user, category: categories[1])

        get(article_of_clothings_url, { category_id: categories[0].id }, authorization_headers(user))

        json = JSON.parse(response.body)
        i = 0
        begin
          article_id = json["article_of_clothings"][i]["id"]
          article_db = ArticleOfClothing.find(article_id)
          article_db_category_id = article_db.category_id

          expect(article_db_category_id).to eq(categories[0].id)

          i += 1
        end while i < articles.length

        expect(response).to have_http_status :ok
        expect(response.body).to have_json_size(3).at_path('article_of_clothings')
      end
    end

    context 'with invalid category id' do
      it 'returns 422 status as category id was not found' do
        user = create(:user)

        category = create(:category)
        invalid_category_id = "12345"

        articles_3 = create_list(:article_of_clothing, 3, user: user, category: category)

        get(article_of_clothings_url, { category_id: invalid_category_id }, authorization_headers(user))

        expect(response).to have_http_status :unprocessable_entity
      end
    end
  end

  describe 'POST /article_of_clothings' do
    context 'with valid category id' do
      it 'returns 200 status and the JSON for the articles of clothing' do

        user = create(:user)
        category = create(:category)

        article_of_clothing_params = {
          article_of_clothing: {
            description: "a blue item",
            category_id: category.id
          }
        }

        post(article_of_clothings_url, article_of_clothing_params.to_json, authorization_headers(user))

        expect(response).to have_http_status :ok
        expect(response.body).to have_json_path('article_of_clothing/id')
        expect(response.body).to have_json_path('article_of_clothing/created_at')
        expect(response.body).to have_json_path('article_of_clothing/updated_at')
        expect(response.body).to have_json_path('article_of_clothing/description')
      end
    end

    context 'with invalid category id' do
      it 'returns 422 status as valid category id was not provided and as such
      the article of clothing was not saved' do

        user = create(:user)
        category = create(:category)
        invalid_id = "#{category.id + '1'}"

        article_of_clothing_params = {
          article_of_clothing: {
            description: "a blue item",
            category_id: invalid_id
          }
        }

        post(article_of_clothings_url, article_of_clothing_params.to_json, authorization_headers(user))

        expect(response).to have_http_status :bad_request
      end
    end
  end

  describe 'PATCH /article_of_clothings/id' do
    context 'with valid attributes' do
      it 'returns JSON for a article of clothing' do
        user = create(:user)
        category = create(:category)

        article = create(:article_of_clothing, user: user, category: category)

        update_article_of_clothing_params = {
          article_of_clothing: {
            description: "a very blue item"
          }
        }

        patch(article_of_clothing_url(article), update_article_of_clothing_params.to_json, authorization_headers(user))

        article.reload

        expect(response).to have_http_status :ok
        expect(article.description).to eq parse_json(update_article_of_clothing_params.to_json)['article_of_clothing']['description']
      end
    end
  end
end
