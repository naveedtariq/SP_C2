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