class ExamsController < ApplicationController
  def index
  end

  def new
  end

  def edit
  end

  def upload_data
    xlsx = Roo::Spreadsheet.open(params[:uploaded_file].path)
    Exam.create(:exam_type => xlsx.cell(2,1), :code => xlsx.cell(3,1), :name => xlsx.cell(4,1), :date => xlsx.cell(5,1))    
    values = []
    exam_id = Exam.last.id
    column = [:exam_id, :q_num, :one, :two, :three, :four]
    for i in 8..57
      values.push [exam_id, xlsx.cell(i,1).to_i, xlsx.cell(i,2), xlsx.cell(i,3), xlsx.cell(i,4), xlsx.cell(i,5)]
    end 
    for i in 60..109
      values.push [exam_id, xlsx.cell(i,1).to_i, xlsx.cell(i,2), xlsx.cell(i,3), xlsx.cell(i,4), xlsx.cell(i,5)]
    end
    Answer.import column, values
    redirect_to root_url
  end
end
