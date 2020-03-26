class DeliveryStatisticJob < ActiveJob::Base
  queue_as :jobs

  # 计成动态的参数， 可以传record_date，DeliveryStatisticJob.perform_now(20200305)， 不传就用默认的
  # curl 127.0.0.1:3003/api/v1/cron_job?job_name=DeliveryStatisticJob&uuid=123456&argument=20200304
  def perform(*args)
    record_date = args.present? && args[0].present? ? args[0] : Time.now.strftime('%Y%m%d').to_i
    # 重新跑任务之前，先删除之前 record_date 相同的记录
    DeliveryStatistic.with_record_date(record_date).delete_all
    Order.with_record_date(record_date).with_done.pluck(:rider_id).uniq.each do |rider_id|
      Order.with_rider_id_record_date(rider_id, record_date).group(:merchant_id).count.each do |key, value|
        create_delivery_statistic(rider_id, key, record_date, value)
      end
    end
  end

  def create_delivery_statistic(rider_id, merchant_id, record_date, count)
    rider = Rider.find_by_id rider_id
    merchant = Merchant.find_by_id merchant_id
    return if rider.blank? || merchant.blank?

    DeliveryStatistic.create!(
      rider_id: rider.id,
      rider_phone: rider.phone,
      rider_group_id: rider.rider_group&.id,
      merchant_id: merchant.id,
      merchant_name: merchant.name,
      merchant_url: merchant.head_url,
      record_date: record_date,
      count: count
    )
  end

end
