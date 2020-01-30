<%@ Page Title="" Language="C#" MasterPageFile="~/IdeaHeaderAndSide.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="IdeaShop._default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="~/MyStyles/default.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <h2><!--This is where search info goes-->
            <asp:Label ID="SeeLabel" runat="server" Text=""></asp:Label></h2>
    <div id ="divSearch" class ="divSearch" >
        <hr />
        <h3>
            <asp:Label ID="lblNoResults" runat="server" Text=""></asp:Label></h3>


        <asp:Repeater ID="rptProducts" runat="server">
            <ItemTemplate>
                    <div class ="media">
                    <a href ='product.aspx?IDPR=<%# Eval("ID_Pr")%>'><!--Put id here-->
                        <div class ="media-left">
                            <asp:Image ID="imgProduct" Width="20em" runat="server" ImageUrl= <%# "~/images/" + Eval("pic")%> Visible ="true" /><!--Put pic here-->
                        </div>
                        <div class ="media-body">
                            <h3 class ="media-heading"><%# Eval("pro_name")%><small>Product ID:<%# Eval("ID_Pr")%></small></h3><!--Put pro_name and ID_Pr-->
                            <h4><%# Eval("price","{0:c}") %></h4><!--Put price-->
                            <p>
                                <%# Eval("descriptionBrief")%>
                            </p>
                            
                        </div>
                     </a>
                        <!--
                        <asp:Button ID="btnFindMe" runat="server" Text="Find Me" OnCommand="FindMe" />-->
                    <hr />
                </div>
            </ItemTemplate>
        </asp:Repeater>    
    

    </div>
</asp:Content>
