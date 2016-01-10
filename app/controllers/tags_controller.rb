class TagsController < ApplicationController
  before_filter :require_login, only: [:destroy]

  def show
    @tag = Tag.find(params[:id])
  end

  def index
    @tags = Tag.all
  end

  def destroy
    @tag = Tag.find(params[:id])
    @taggings = Tagging.all
    @taggings.each do |tagging|
      if tagging.tag_id == params[:id]
        Tagging.find(tagging.id).destroy
      end
    end
    @tag.destroy
    flash.notice = "Tag '#{@tag.name}' Deleted!"
    redirect_to tags_path
  end
end
