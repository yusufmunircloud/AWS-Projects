# What Are We Building?

In this project, we are developing a real-life application that leverages the power of machine learning. Our goal is to create a service that delivers top news stories to users while also providing insights into the sentiment of those news articles.

## Overview

Our project is primarily based on AWS Lambda, a serverless computing service. Here's what the application does:

1. **News Retrieval:** The Lambda function interacts with a news API to fetch the latest top news stories.

2. **Sentiment Analysis:** After retrieving the news articles, our Lambda function utilizes Amazon Comprehend, an AWS service for natural language processing, to determine the sentiment of each news article. The sentiment is categorized as positive, negative, or neutral.

3. **Data Storage:** The sentiment analysis results are then saved along with the news articles in Amazon DynamoDB, an AWS NoSQL database service.

4. **API Interaction:** Our project exposes API endpoints that allow users to request news articles based on their desired sentiment. Users can choose to fetch positive, negative, or neutral news.

5. **Automation:** The Lambda function can be triggered at specified intervals, such as hourly or daily, using Amazon CloudWatch Events. This scheduling capability allows us to automate the entire process, making it function like a cron job.

![](https://github.com/yusufmunircloud/AWS-Projects/blob/main/img/sentiment-img/sentimentai-architecture.png?raw=true)

## Why It Matters

In the past, determining the sentiment of news articles typically required running custom Python or machine learning programs. However, with Amazon Comprehend, we can easily analyze and categorize news sentiment, making it more accessible and efficient.

Our project enables users to access news stories that match their preferred sentiment, providing a more personalized news experience.

Additionally, we have the flexibility to automate the entire process, making it easier to keep the news database up-to-date with the latest articles.

Let's dive into the code and see this project in action!
