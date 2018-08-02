/* Magic Mirror Config Sample
 *
 * By Michael Teeuw http://michaelteeuw.nl
 * MIT Licensed.
 *
 * For more information how you can configurate this file
 * See https://github.com/MichMich/MagicMirror#configuration
 *
 */

var config = {
	address: "localhost", // Address to listen on, can be:
	                      // - "localhost", "127.0.0.1", "::1" to listen on loopback interface
	                      // - another specific IPv4/6 to listen on a specific interface
	                      // - "", "0.0.0.0", "::" to listen on any interface
	                      // Default, when address config is left out, is "localhost"
	port: 8080,
	ipWhitelist: ["127.0.0.1", "::ffff:127.0.0.1", "::1"], // Set [] to allow all IP addresses
	                                                       // or add a specific IPv4 of 192.168.1.5 :
	                                                       // ["127.0.0.1", "::ffff:127.0.0.1", "::1", "::ffff:192.168.1.5"],
	                                                       // or IPv4 range of 192.168.3.0 --> 192.168.3.15 use CIDR format :
	                                                       // ["127.0.0.1", "::ffff:127.0.0.1", "::1", "::ffff:192.168.3.0/28"],

	language: "en",
	timeFormat: 24,
	units: "imperial",

	modules: [
    /*
		{
			module: "MMM-Wallpaper",
      position: 'fullscreen_below',
      config: {
        source: "local",
        // Changes slides every minute
        slideInterval: 5 * 1000
      }
		},
		{
			module: "EyeCandy",
      position: 'fullscreen_below',
      config: {
        source: ~/home/data",
        // Changes slides every minute
        slideInterval: 5 * 1000
      }
		},
    */
		{
			module: "MMM-ImageSlideshow",
			position: 'fullscreen_below',
			config: {
        imagePaths: ['modules/MMM-ImageSlideshow/photos'],
        randomizeImageOrder: true,
        fixedImageWidth: 1920,
        fixedImageHeight: 1080   
      }
		},
		{
			module: "alert",
		},
		{
			module: "clock",
			position: "top_left"
		},
		{
			module: "calendar",
			header: "US Holidays",
			position: "top_left",
			config: {
				calendars: [
					{
						symbol: "calendar-check-o ",
						url: "webcal://www.calendarlabs.com/templates/ical/US-Holidays.ics"
					}
				]
			}
		},
		{
			module: "compliments",
			position: "top_bar"
		},
		{
			module: "currentweather",
			position: "top_right",
			config: {
				location: "Austin",
				locationID: "4671654",  //ID from http://www.openweathermap.org/help/city_list.txt
				appid: "1a7e76775dbd5fc379cc122207103b2e",
			}
		},
		{
			module: "weatherforecast",
			position: "top_right",
			header: "Weather Forecast",
			config: {
				location: "Austin",
				locationID: "4671654",  //ID from http://www.openweathermap.org/help/city_list.txt
				appid: "1a7e76775dbd5fc379cc122207103b2e",
			}
		},
		{
			module: "newsfeed",
			position: "lower_third",
			config: {
				feeds: [
					{
						title: "New York Times",
						url: "http://www.nytimes.com/services/xml/rss/nyt/HomePage.xml"
					}
				],
				showSourceTitle: true,
				showPublishDate: true
			}
		},
		{
			module: "MMM-Carousel",
			position: "bottom_bar",
			config: {
				mode: 'slides',
        slides: [
          ['clock', 'compliments', 'currentweather'],
          ['newsfeed', 'weatherforecast', 'calendar'],
          ['MMM-ImageSlideshow']
        ],
        ignoreModules: [
          'alert',
        ], 
				transitionInterval: 0000,
        showPageControls: true,
        showPageIndicators: false
			}
		},
	]

};

/*************** DO NOT EDIT THE LINE BELOW ***************/
if (typeof module !== "undefined") {module.exports = config;}
