local limite_tokens = 100000 --Recuerde que esto es un prototipo, recomendable utilizar esto en una base de datos.
local tokens_realizadas = 0 --Recuerde que esto es un prototipo, recomendable utilizar esto en una base de datos.

--Le especificamos como se comportará, para que conteste como tal.
local base_prompt = 'Te comportarás como un personaje y te diré a continuación como deberás actuar. Eres un sujeto llamado Hung Ngo y eres desarrollador de Front-End, eres una persona humilde. Ahora responderás a alguien que te ha dicho lo siguiente: '

lib.callback.register('mk-npcIA:getResponse', function(source, question)
    local response_ia = generateText(question)
	return question
end)

function generateText(question_prompt)
    if tokens_realizadas >= limite_tokens-10000 then --Es preferible prevenir 10.000 tokens antes, que ha pagar una factura de OpenAI
        print("Se ha alcanzado el límite máximo de solicitudes para este mes.")
        return 'Estoy algo agotado. No me preguntes más cosas' --respuesta default, en caso que los tokens se agoten.
    end

    local headers = {
        ['Content-Type'] = 'application/json',
        ['Authorization'] = 'Bearer ' .. Config.apikey,
    }
    local data = {
        ["model"] = "text-davinci-003",
        ['prompt'] = base_prompt..' '..question_prompt,
        ['temperature'] = 0.2,
        ['max_tokens'] = 30,
        ["logprobs"] = 10,
    }
    local jsonData = json.encode(data)
    local responseText = ''
    local tokens_used = 0
    PerformHttpRequest(Config.url, function(errorCode, responseText, headers)
        print('Response Code: ' .. tostring(errorCode))
        --print('Response Text: ' .. responseText)
        if errorCode ~= 200 then
            print('Error al utilizar la API')
            return
        end
        local jsonResponse = json.decode(responseText)
        if jsonResponse.choices and jsonResponse.choices[1] then
            responseText = jsonResponse.choices[1].text
            tokens_used = jsonResponse.choices[1].tokens_used;
            tokens_realizadas = tokens_realizadas+tokens_used
        end
    end, 'POST', jsonData, headers)
    --para no sobrepasar nuestras consultas gratuitas y estar al tanto.
    print('La última consulta ha costado un total de '..tokens_used..' tokens.')
    return responseText
end
