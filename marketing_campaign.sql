use marketing;
select * from performance;

## Understanding the Overall KPIs for the different campaigns
select 
	campaign_id,
	format(sum(impressions),2) as Total_impressions,
    format( sum(cost_usd)/sum(clicks),2) as cost_per_click,
    format((sum(clicks)/sum(impressions))*100,2) as click_through_rate,
    format(sum(cost_usd)/sum(conversions),2) as cost_per_acquisition,
    format((sum(conversions)/sum(clicks))*100,2) as conversion_rate,
    format((sum(revenue_usd)/sum(cost_usd))*100,2) as return_on_ad_spend
from performance
group by campaign_id order by return_on_ad_spend desc limit 5;

select * from regions;

## KPIs by Regions
select 
	r.region_name,
	format(sum(p.impressions),2) as Total_impressions,
    format( sum(p.cost_usd)/sum(p.clicks),2) as cost_per_click,
    format((sum(p.clicks)/sum(p.impressions))*100,2) as click_through_rate,
    format(sum(p.cost_usd)/sum(p.conversions),2) as cost_per_acquisition,
    format((sum(p.conversions)/sum(p.clicks))*100,2) as conversion_rate,
    format((sum(p.revenue_usd)/sum(p.cost_usd))*100,2) as return_on_ad_spend
from performance p
left join regions r on r.region_id=p.region_id
group by r.region_name
order by return_on_ad_spend;

## Channel Performance
select * from channels;

select 
	c.channel_name,
	format(sum(p.impressions),2) as Total_impressions,
    format( sum(p.cost_usd)/sum(p.clicks),2) as cost_per_click,
    format((sum(p.clicks)/sum(p.impressions))*100,2) as click_through_rate,
    format(sum(p.cost_usd)/sum(p.conversions),2) as cost_per_acquisition,
    format((sum(p.conversions)/sum(p.clicks))*100,2) as conversion_rate,
    format(sum(p.revenue_usd)/sum(p.cost_usd),2) as return_on_ad_spend
from performance p
left join channels c on c.channel_id=p.channel_id
group by c.channel_name
order by return_on_ad_spend desc;

## Device performance
select * from devices;
select 
	d.device_type,
	format(sum(p.impressions),2) as Total_impressions,
    format( sum(p.cost_usd)/sum(p.clicks),2) as cost_per_click,
    format((sum(p.clicks)/sum(p.impressions))*100,2) as click_through_rate,
    format(sum(p.cost_usd)/sum(p.conversions),2) as cost_per_acquisition,
    format((sum(p.conversions)/sum(p.clicks))*100,2) as conversion_rate,
    format((sum(p.revenue_usd)/sum(p.cost_usd)),2) as return_on_ad_spend
from performance p
left join devices d on d.device_id=p.device_id
group by d.device_type
order by return_on_ad_spend desc;


select * from channels;

select 
	c.channel_name,
    r.region_name,
	format(sum(p.impressions),2) as Total_impressions,
    format( sum(p.cost_usd)/sum(p.clicks),2) as cost_per_click,
    format((sum(p.clicks)/sum(p.impressions))*100,2) as click_through_rate,
    format(sum(p.cost_usd)/sum(p.conversions),2) as cost_per_acquisition,
    format((sum(p.conversions)/sum(p.clicks))*100,2) as conversion_rate,
    format(sum(p.revenue_usd)/sum(p.cost_usd),2) as return_on_ad_spend
from performance p
left join channels c on c.channel_id=p.channel_id
left join regions r on r.region_id=p.region_id
group by c.channel_name, r.region_name
having r.region_name='South'
order by return_on_ad_spend desc;

### Channel Rank within each Region

Select 
    c.channel_name,
    r.region_name,
    format(sum(p.revenue_usd)/sum(p.cost_usd),2) as roas,
    rank() over(partition by c.channel_name order by sum(p.revenue_usd)/sum(p.cost_usd) desc) as region_rank
from 
performance p 

join channels c on c.channel_id=p.channel_id
join regions r on r.region_id=p.region_id
group by c.channel_name, 
			r.region_name;
