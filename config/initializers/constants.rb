  # To change this template, choose Tools | Templates
# and open the template in the editor.
GENDER = ["Male", "Female"]
#RIDETYPE=["Sedon", "Suv", "Van"]
IMAGE_SIZE="10"
SEARCH_OPTION_ONE_IN_DAYS = 15
SEARCH_OPTION_TWO_IN_DAYS = 30
ROLES_FOR_RIDES = {
    :owner => 1,
    :pending => 2,
    :confirmed => 3,
    :abandoned => 4,
    :expired => 5,
    :rejected => 6,
    :canceled => 7
}
PAST_RIDES_PER_PAGE = 5
SEARCH_RIDES_PER_PAGE = 20
STATUS_FOR_RIDES = {
  :active => 1,
  :canceled => 2
}
GOOGLE_ANALYTICS = "<script type=\"text/javascript\">

  var _gaq = _gaq || [];
  _gaq.push(['_setAccount', 'UA-29738820-1']);
  _gaq.push(['_trackPageview']);

  (function() {
    var ga = document.createElement('script'); ga.type = 'text/javascript'; ga.async = true;
    ga.src = ('https:' == document.location.protocol ? 'https://ssl' : 'http://www') + '.google-analytics.com/ga.js';
    var s = document.getElementsByTagName('script')[0]; s.parentNode.insertBefore(ga, s);
  })();

</script>"

MIXPANEL = "<script type=\"text/javascript\">
var mpq=[];mpq.push(['init', 'dc892638d7e815ceb9e257c44d6c4a05']);
(function(){var b,a,e,d,c;b=document.createElement('script');
b.type='text/javascript';
b.async=true;
b.src=(document.location.protocol=== 'https:'?'https:':'http:')+'api.mixpanel.com/site_media/js/api/mixpanel.js';
a=document.getElementsByTagName('script')[0];
a.parentNode.insertBefore(b,a);
e=function(f){return function(){mpq.push([f].concat(Array.prototype.slice.call(arguments,0)))}};
d=['init','track','track_links','track_forms','register','register_once','identify','name_tag','set_config'];
for(c=0;c<d.length;c++){mpq[d[c]]=e(d[c])}})();
</script>"

GETCLICKY = "<script src='http://static.getclicky.com/js' type='text/javascript'></script>
<script type='text/javascript'>try{ clicky.init(66553995); }catch(e){}</script>
<noscript><p><img alt='Clicky' width='1' height='1' src='in.getclicky.com/66553995ns.gif' /></p></noscript>"

KISSMETRICS = "<script type='text/javascript'>
    var _kmq = _kmq || [];
    function _kms(u){
    setTimeout(function(){
    var s = document.createElement('script'); var f = document.getElementsByTagName('script')[0]; s.type = 'text/javascript'; s.async = true;
    s.src = u; f.parentNode.insertBefore(s, f);
    }, 1);
    }
    _kms('//i.kissmetrics.com/i.js');_kms('//doug1izaerwt3.cloudfront.net/76b6b624ef34a2ff61ef145f5b92b28af2ea8b8c.1.js');
    </script>"

  CRAZYEGG = ""

  GOOGLE_ANALYTICS_TOGGLE = "ON"
  MIXPANEL_TOGGLE = "ON"
  GETCLICKY_TOGGLE = "ON"
  KISSMETRICS_TOGGLE = "ON"
  CRAZYEGG_TOGGLE = "ON"



