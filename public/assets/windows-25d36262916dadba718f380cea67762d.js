/* 
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
function check_login(){$.ajax({url:"/users/logged_in",success:function(a){a=="true"&&$(".book-ride-child-window").submit()}})}$(document).ready(function(){$("#book-ride-child-window").click(function(){return setInterval("check_login()",5e3),window.open("/login","Ratting","width=1080,height=700,left=150,top=200,toolbar=0,status=0,scrollbars=1"),!1})});