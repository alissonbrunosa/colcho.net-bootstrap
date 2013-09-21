module ApplicationHelper

	# Código que gera o html para informar um error em um campo do fórmulario
	# Ex.: <span class="label label-danger help-inline">Menssagem de error aqui!</span>
	def error_tag(model, attribute)
		if model.errors.has_key? attribute
			error = model.errors[attribute].first
			content_tag :span, error, :class => 'label label-danger help-inline'
		end
	end
	
end
