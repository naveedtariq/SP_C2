  # To change this template, choose Tools | Templates
# and open the template in the editor.
GENDER = ["Male", "Female"]                                                     # Gender array
#RIDETYPE=["Sedon", "Suv", "Van"]
IMAGE_SIZE="10"                                                                 # Image size uploading by user
SEARCH_OPTION_ONE_IN_DAYS = 15                                                  # Search Rides for next 15 days
SEARCH_OPTION_TWO_IN_DAYS = 30                                                  # search rides with in Moth
ROLES_FOR_RIDES = {                                                             # Rider's Role define here
    :owner => 1,
    :pending => 2,
    :confirmed => 3,
    :abandoned => 4,
    :expired => 5,
    :rejected => 6,
    :canceled => 7
}
PAST_RIDES_PER_PAGE = 5                                                         # past Rides per page
SEARCH_RIDES_PER_PAGE = 20                                                      # Total search result rides per page
STATUS_FOR_RIDES = {                                                            # Status of rider either active or cancel
  :active => 1,
  :canceled => 2
}

NEW_DEPARTURE_TIME = ["01:00", "01:15", "01:30", "01:45", "02:00", "02:15", "02:30", "02:45", "03:00", "03:15", "03:30", "03:45", "04:00", "04:15", "04:30", "04:45", "05:00", "05:15", "05:30", "05:45", "06:00", "06:15", "06:30", "06:45", "07:00", "07:15", "07:30", "07:45", "08:00", "08:15", "08:30", "08:45", "09:00", "09:15", "09:30", "09:45", "10:00", "10:15", "10:30", "10:45", "11:00", "11:15", "11:30", "11:45", "12:00", "12:15", "12:30", "12:45"]
AM_PM_TIME = ["AM", "PM"]

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

  GOOGLE_ANALYTICS_TOGGLE = "ON"                                                # google_toogle on/off
  MIXPANEL_TOGGLE = "ON"                                                        # mixpanel_toggle on/off
  GETCLICKY_TOGGLE = "ON"                                                       # getclicky_toggle on/off
  KISSMETRICS_TOGGLE = "ON"                                                     # kissmetrics_toggle on/off
  CRAZYEGG_TOGGLE = "ON"                                                        # crazyegg_toggle on/off
  BASE_URL = "ec2-50-17-68-61.compute-1.amazonaws.com"


