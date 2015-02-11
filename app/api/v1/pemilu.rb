module Pemilu
  class APIv1 < Grape::API
    version 'v1', using: :accept_version_header
    prefix 'api'
    format :json

    resource :agenda do
      desc "Return all DPR Schedule"
      get do
        schedules = Array.new

        # Prepare conditions based on params
        valid_params = {
          tanggal: 'date'
        }
        conditions = Hash.new
        valid_params.each_pair do |key, value|
          conditions[value.to_sym] = params[key.to_sym] unless params[key.to_sym].blank?
        end

        limit = (params[:limit].to_i == 0 || params[:limit].empty?) ? 50 : params[:limit]

        Schedule.where(conditions)
          .limit(limit)
          .offset(params[:offset])
          .each do |schedule|
            schedules << {
              id: schedule.id,
              link: schedule.link,
              title: schedule.title,
              time: schedule.time,
              date: schedule.date
            }
          end

          {
            results: {
              count: schedules.count,
              total: Schedule.where(conditions).count,
              schedule: schedules
            }
          }
      end
    end
  end
end