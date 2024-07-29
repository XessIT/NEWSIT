const baseUrl = 'http://stg-api-alb-1550582675.ap-south-1.elb.amazonaws.com/core-svc/api';
const version = 'v1';
const apiUrl = '$baseUrl/$version';

const otpUrl = '$apiUrl/users/signup-mobile';
const googleUrl = '$apiUrl/users/social-login';
const verifyotpUrl = '$apiUrl/users/verify-mobile';
const cityGet = '$apiUrl/cities';
const WelcomeUrl = '$apiUrl/users/profile';
const locationUrl = '$apiUrl/users/profile/preferences';
const categoryUrl = '$apiUrl/categories/search';
const getNewsUrl = 'http://stg-api-alb-1550582675.ap-south-1.elb.amazonaws.com/news-svc/api/v1/newsfeed';
