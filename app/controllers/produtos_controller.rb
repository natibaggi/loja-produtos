class ProdutosController < ApplicationController

    def index
        @todos_produtos = Produto.order(nome: :asc)
        @produto_mais_barato = Produto.order(:preco).limit(1)
    end

    def new
        @produto = Produto.new
        @departamentos = Departamento.all
    end

    def create
        valores = params.require(:produto).permit(:nome, :descricao, :preco, :quantidade, :departamento_id)
        @novo_produto = Produto.new(valores)
        @departamentos = Departamento.all
        
        if @novo_produto.save
            flash[:notice] = "Produto salvo com sucesso!"
            redirect_to root_url
        else
            render :new_with_errors
        end
    end

    def edit
        id = params[:id]
        @produto = Produto.find(id)
        @departamentos = Departamento.all
        render :new
    end

    def update
        
    end

    def destroy
        id = params[:id]
        Produto.destroy id
        redirect_to root_url
    end

    def busca
        @nome = params[:texto_busca]
        @produtos = Produto.where("nome like ?", "%#{@nome}%")

    end
    
end     
