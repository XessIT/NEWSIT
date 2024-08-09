const CorebaseUrl = 'http://stg-api-alb-1550582675.ap-south-1.elb.amazonaws.com/core-svc/api';
const NewsbaseUrl = 'http://stg-api-alb-1550582675.ap-south-1.elb.amazonaws.com/news-svc/api';
const version = 'v1';
const CoreapiUrl = '$CorebaseUrl/$version';
const NewsapiUrl = '$NewsbaseUrl/$version';

// Core Api
const otpUrl = '$CoreapiUrl/users/signup-mobile';
const googleUrl = '$CoreapiUrl/users/social-login';
const verifyotpUrl = '$CoreapiUrl/users/verify-mobile';
const cityGet = '$CoreapiUrl/cities';
const WelcomeUrl = '$CoreapiUrl/users/profile';
const locationUrl = '$CoreapiUrl/users/profile/preferences';
const categoryUrl = '$CoreapiUrl/categories/search';
const reachUrl = '$CoreapiUrl/reaches';


// News Api
const getNewsUrl = '$NewsapiUrl/newsfeed';
