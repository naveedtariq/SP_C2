/*
 * jQuery validate.password plug-in 1.0
 *
 * http://bassistance.de/jquery-plugins/jquery-plugin-validate.password/
 *
 * Copyright (c) 2009 Jörn Zaefferer
 *
 * $Id$
 *
 * Dual licensed under the MIT and GPL licenses:
 *   http://www.opensource.org/licenses/mit-license.php
 *   http://www.gnu.org/licenses/gpl.html
 */
(function(a){function h(a,b){return{rate:a,messageKey:b}}function i(a){return a.substring(0,1).toLowerCase()+a.substring(1)}var b=/[a-z]/,c=/[A-Z]/,d=/[0-9]/,e=/[0-9].*[0-9]/,f=/[^a-zA-Z0-9]/,g=/^(.)\1+$/;a.validator.passwordRating=function(a,j){if(!a||a.length<8)return h(0,"too-short");if(j&&a.toLowerCase().match(j.toLowerCase()))return h(0,"similar-to-username");if(g.test(a))return h(1,"very-weak");var k=b.test(a),l=c.test(i(a)),m=d.test(a),n=e.test(a),o=f.test(a);return k&&l&&m||k&&n||l&&n||o?h(4,"strong"):k&&l||k&&m||l&&m?h(3,"good"):h(2,"weak")},a.validator.passwordRating.messages={"similar-to-username":"Too similar to username","too-short":"Too short","very-weak":"Very weak",weak:"Weak",good:"Good",strong:"Strong"},a.validator.addMethod("password",function(b,c,d){var e=c.value,f=a(typeof d!="boolean"?d:[]),g=a.validator.passwordRating(e,f.val()),h=a(".password-meter",c.form);return h.find(".password-meter-bar").removeClass().addClass("password-meter-bar").addClass("password-meter-"+g.messageKey),h.find(".password-meter-message").removeClass().addClass("password-meter-message").addClass("password-meter-message-"+g.messageKey).text(a.validator.passwordRating.messages[g.messageKey]),g.rate>2},"&nbsp;"),a.validator.classRuleSettings.password={password:!0}})(jQuery);