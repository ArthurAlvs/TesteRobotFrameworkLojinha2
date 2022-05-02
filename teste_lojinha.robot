*** Settings ***
Library     SeleniumLibrary

Test Setup        Abrir Navegador
Test Teardown     Fechar Navegador

*** Test Case ***
Compra na lojinha
    Acessar homepage da lojinha
    Pesquisar Blouse
    Comprar Blouse
    Checkout Carrinho
    Criar Conta
    Finalizar Compra

*** Variables ***
${URL}                                  http://automationpractice.com/
${BARRA_PESQUISAR}                      search_query_top
${BLOUSE_TITULO}                        //img[@src='http://automationpractice.com/img/p/7/7-home_default.jpg']
${ADICIONAR_AO_CARRINHO}                //a[@class='button ajax_add_to_cart_button btn btn-default'][contains(.,'Add to cart')]
${PROCEED_TO_CHECKOUT}                  //a[@class='btn btn-default button button-medium'][contains(.,'Proceed to checkout')]
${BOTAO_REGISTER}                       //button[@type='submit'][contains(.,'Register')]
${BOTAO_PROCEED_TO_CHECKOUT}            //button[@type='submit'][contains(.,'Proceed to checkout')]

*** Keywords ***
Abrir Navegador
    Open Browser                        browser=chrome
    Maximize Browser Window

Fechar Navegador
    Capture Page Screenshot
    Close Browser

Acessar homepage da lojinha
    Go To                                url=${URL}
    Wait Until Element Is Visible        ${BARRA_PESQUISAR}

Pesquisar Blouse
    Input Text                       ${BARRA_PESQUISAR}    Blouse
    Click Element                    submit_search
    Wait Until Element Is Visible    ${BLOUSE_TITULO}    

Comprar Blouse
    Wait Until Element Is Visible     locator=id=list
    Click Element                     locator=id=list
    Wait Until Element Is Visible     locator=${ADICIONAR_AO_CARRINHO}
    Scroll Element Into View          locator=${ADICIONAR_AO_CARRINHO}
    Element Should Be Visible         locator=${ADICIONAR_AO_CARRINHO}
    Click Element                     locator=${ADICIONAR_AO_CARRINHO}
    Wait Until Element Is Visible     locator=${PROCEED_TO_CHECKOUT}
    Click Element                     locator=${PROCEED_TO_CHECKOUT}

Checkout Carrinho
    Wait Until Element Is Visible    locator=//a[contains(@class,'button btn btn-default standard-checkout button-medium')]
    Click Element                    locator=//a[contains(@class,'button btn btn-default standard-checkout button-medium')]
    Wait Until Element Is Visible    locator=email_create
    Input Text                       email_create    joildoafonso08@gmail.com
    Click Element                    locator=//button[@class='btn btn-default button button-medium exclusive'][contains(.,'Create an account')]   

Criar Conta
    Wait Until Element Is Visible    //h1[@class='page-heading'][contains(.,'Create an account')]
    Wait Until Element Is Visible    locator=uniform-id_gender1
    Click Element                    locator=uniform-id_gender1
    Input Text                       locator=customer_firstname       text=Joildo
    Input Text                       locator=customer_lastname        text=Afonso
    Input Password                   locator=passwd    password=Aa1998Aa
    Select From List By Value        id=days          6
    Select From List By Value        id=months        7
    Select From List By Value        id=years         1900
    Input Text                       locator=address1    text=Rua dos Bobos n 0
    Input Text                       locator=city        text=Twin Peaks
    Select From List By Value        id_state  47
    Input Text                       locator=postcode       text=66666
    Input Text                       locator=phone_mobile   text=+1(666)555-4321
    Click Element                    locator=${BOTAO_REGISTER}
    Wait Until Element Is Visible    locator=${BOTAO_PROCEED_TO_CHECKOUT}
    Click Element                    ${BOTAO_PROCEED_TO_CHECKOUT}

Finalizar Compra
    Wait Until Element Is Visible    locator=uniform-cgv
    Click Element                    locator=uniform-cgv
    Click Element                    locator=${BOTAO_PROCEED_TO_CHECKOUT} 
    Wait Until Element Is Visible    locator=//a[@class='bankwire'][contains(.,'Pay by bank wire (order processing will be longer)')]
    Click Element                    //a[@class='bankwire'][contains(.,'Pay by bank wire (order processing will be longer)')]
    Wait Until Element Is Visible    locator=//button[@class='button btn btn-default button-medium'][contains(.,'I confirm my order')]
    Click Element                    //button[@class='button btn btn-default button-medium'][contains(.,'I confirm my order')]
    Sleep    5