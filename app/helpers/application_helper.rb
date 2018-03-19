module ApplicationHelper
  def field_with_validation(model, field)
    if model.errors[field].empty?
      'form-control'
    else
      'form-control is-invalid'
    end
  end

  def field_error_message(model, field)
    return if model.errors[field].empty?

    content_tag :p, class: 'error-message' do
      model.errors[field].first.humanize
    end
  end

  def general_error_message(model)
    if model.errors.any?
      content_tag :div, class: 'alert alert-danger' do
        "Ocurrieron #{model.errors.count} errores al tratar de guardar la información"
      end
    end
  end
end
