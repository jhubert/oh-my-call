# Provides the standard API CRUD responses for a resource
module StandardApiResource
  def index
    @collection = resource.load
    respond_with :api, @collection
  end

  def show
    respond_with :api, @instance
  end

  def create
    @instance = resource.create(permitted_params)
    respond_with :api, @instance, template: 'api/v1/people/show'
  end

  def update
    @instance.update_attributes(permitted_params)
    head :no_content
  end

  def destroy
    @instance.destroy
    head :no_content
  end

  private

  def set_instance_from_params
    @instance = resource.find(params[:id])
  end
end
