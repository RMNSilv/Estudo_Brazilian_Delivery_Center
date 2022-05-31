CREATE TABLE exe04.entregas(
  `deliveries_id` text, 
  `delivery_order_id` text,
  `driver_id` text,
  `delivery_distance_meters` text,
  `delivery_status` text
);

CREATE TABLE exe04.motoristas (
  `driver_id` text,
  `driver_modal` text,
  `driver_type` text
);

CREATE TABLE exe04.centros (
  `hub_id` text,
  `hub_name` text,
  `hub_city` text,
  `hub_state` text,
  `hub_latitude` text,
  `hub_longitude` text
);

CREATE TABLE exe04.pedidos (
`order_id` text,
`store_id` text,
`channel_id` text,
`payment_order_id` text,
`delivery_order_id` text,
`order_status` text,
`order_amount` text,
`order_delivery_fee` text,
`order_delivery_cost` text,
`order_created_hour` text,
`order_created_minute` text,
`order_created_day` text,
`order_created_month` text,`order_created_year`text,
`order_moment_created` text,
`order_moment_accepted`text,
`order_moment_ready`text,
`order_moment_collected` text, 
`order_moment_in_expedition` text,
`order_moment_delivering` text,
`order_moment_delivered` text, 
`order_moment_finished` text,
`order_metric_collected_time` text,
`order_metric_paused_time` text,
`order_metric_production_time`text,
`order_metric_walking_time` text,
`order_metric_expediton_speed_time` text,
`order_metric_transit_time` text,
`order_metric_cycle_time` text
);

CREATE TABLE exe04.pagamentos (
`payment_id` text,
`payment_order_id` text,
`payment_amount` text,
`payment_fee` text,
`payment_method` text,
`payment_status` text
);

CREATE TABLE exe04.lojas (
`store_id` text,
`hub_id` text,
`store_name` text,
`store_segment` text,
`store_plan_price` text,
`store_latitude` text,
`store_longitude` text
);
