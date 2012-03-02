/*
* Password Strength (0.1.2)
* by Sagie Maoz (n0nick.net)
* n0nick@php.net
*
* This plugin will check the value of a password field and evaluate the
* strength of the typed password. This is done by checking for
* the diversity of character types: numbers, lowercase and uppercase
* letters and special characters.
*
* Copyright (c) 2010 Sagie Maoz <n0nick@php.net>
* Licensed under the GPL license, see http://www.gnu.org/licenses/gpl-3.0.html
*
*
* NOTE: This script requires jQuery to work. Download jQuery at www.jquery.com
*
*/
(function(a){var b=new function(){this.countRegexp=function(a,b){var c=a.match(b);return c?c.length:0},this.getStrength=function(a,b){var c=a.length;if(c<b)return 0;var d=this.countRegexp(a,/\d/g),e=this.countRegexp(a,/[a-z]/g),f=this.countRegexp(a,/[A-Z]/g),g=c-d-e-f;if(d==c||e==c||f==c||g==c)return 1;var h=0;return d&&(h+=2),e&&(h+=f?4:3),f&&(h+=e?4:3),g&&(h+=5),c>10&&(h+=1),h},this.getStrengthLevel=function(a,b){var c=this.getStrength(a,b);return a=1,c<=0?a=1:c>0&&c<=4?a=2:c>4&&c<=8?a=3:c>8&&c<=12?a=4:c>12&&(a=5),a}};a.fn.password_strength=function(c){var d=a.extend({container:null,bar:null,minLength:6,texts:{1:"Too weak",2:"Weak password",3:"Normal strength",4:"Strong password",5:"Very strong password"},onCheck:null},c);return this.each(function(){var c=null,e=null;d.container?c=a(d.container):(c=a("<span/>").attr("class","password_strength"),a(this).after(c)),d.bar&&(e=a(d.bar)),a(this).bind("keyup.password_strength",function(){var f=a(this).val(),g=b.getStrengthLevel(f,d.minLength);if(f.length>0){var h="password_strength_"+g,i="password_bar_"+g;!c.hasClass(h)&&g in d.texts&&c.text(d.texts[g]).attr("class","password_strength "+h),e&&!e.hasClass(i)&&e.attr("class","password_bar "+i)}else c.text("").attr("class","password_strength"),e&&e.attr("class","password_bar");d.onCheck&&d.onCheck.call(this,g)}),a(this).val()!=""&&a(this).trigger("keyup.password_strength")})}})(jQuery);