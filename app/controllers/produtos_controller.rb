class ProdutosController < ApplicationController
    before_action :set_produto, only: [:edit, :update, :destroy]


    def index
        @todos_produtos = Produto.order(nome: :asc)
        @produto_mais_barato = Produto.order(:preco).limit(1)
    end

    def new
        @produto = Produto.new
        departamento_renderiza
    end

    def create
        @produto = Produto.new(produto_params)
        @departamentos = Departamento.all
        
        if @produto.save
            flash[:notice] = "Produto salvo com sucesso!"
            redirect_to root_url
        else
            departamento_renderiza
        end
    end

    # navegador está pedindo o form de edição do produto de ID=params[:id]
    # params = Hash ou seja, sempre acessar com [] que nem o array
    def edit
        departamento_renderiza
    end

    # navegador está enviando os params para serem atualizados no produto
    def update
        # resgata valores enviados no formulário
        if @produto.update(produto_params)
            flash[:notice] = "Produto atualizado com sucesso!"
            redirect_to root_url
        else
            departamento_renderiza
        end
    end

    def destroy
        @produto.destroy
        redirect_to root_url
    end

    def busca
        @nome = params[:texto_busca]
        @produtos = Produto.where("nome like ?", "%#{@nome}%")
    end


    protected
    def produto_params
        params.require(:produto).permit(:nome, :descricao, :preco, :quantidade, :departamento_id) 
    end
    
    def set_produto
        id = params[:id]
        @produto = Produto.find(id)
    end

    def departamento_renderiza
        @departamentos = Departamento.all
        render :new
    end

end     
