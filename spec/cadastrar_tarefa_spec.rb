describe 'Cadastrar' do
    def login(field_email, field_password)
    @body = {
        session: {
            email: field_email,
            password: field_password
        }
    }.to_json
        @login = Login.post('/sessions', body: @body)
        puts @login.body
    end

    context 'tarefas' do
        before { login('brunobatista66@gmail.com' , '123456') }

        it 'com suceso' do
        @header = {
            'Content-Type': 'application/json',
             Accept: 'application/vnd.tasksmanagers.v2',
             Authorization: @login.parsed_response['data']['attributes']['auth-token']
        }

        @body = {
            task: {
                title:'criei tarefa',
                description: 'Descricao da tarefa',
                deadline: '2022-04-22 15:00:09',
                done: true
            }
        }.to_json

        @tarefas = Cadastrar.post('/tasks', body: @body, headers: @header)
        puts @tarefas
        expect(@tarefas.parsed_response['data']['attributes']['title']).to eq 'criei tarefa'
        end
    end
end