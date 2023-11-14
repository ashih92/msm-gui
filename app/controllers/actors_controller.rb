class ActorsController < ApplicationController
  def create
    #paramshash looks like this:

    m = Actor.new
    m.name = params.fetch("the_name")
    m.dob = params.fetch("the_dob")
    m.bio = params.fetch("the_bio")
    m.image = params.fetch("the_image")
  

    m.save

    redirect_to("/actors")
    #retrieve the user's inputs from params
    #create a record in the movie table
    #populate each column with the user input
    # save

    #redirect the user back to the /movies URL
  end

  def destroy
      the_id = params.fetch("an_id")
      matching_records = Actor.where({ :id => the_id })
      the_actor=matching_records.at(0)
      the_actor.destroy
      redirect_to("/actors")
  end
  def index
    matching_actors = Actor.all
    @list_of_actors = matching_actors.order({ :created_at => :desc })

    render({ :template => "actor_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_actors = Actor.where({ :id => the_id })
    @the_actor = matching_actors.at(0)
      
    render({ :template => "actor_templates/show" })
  end
end
