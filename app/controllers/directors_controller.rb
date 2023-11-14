class DirectorsController < ApplicationController
  def update
    #get the id out of params
    m_id = params.fetch("the_id")
    #look up the existing record
    matching_records = Director.where({ :id => m_id })
    the_director = matching_records.at(0)
    #overwrite each coloumn with the values fro user inputs
    the_director.title = params.fetch("the_title")
    the_director.year = params.fetch("the_year")
    the_director.duration = params.fetch("the_duration")
    the_director.description = params.fetch("the_description")
    the_director.image_field = params.fetch("the_image")
    the_director.director_id = params.fetch("the_director_id")
   
    #save
    the_director.save

    #rediect to the movie details page
    redirect_to("/directors/#{the_director.id}")
  end
  
  def create
    #paramshash looks like this:

    m = Director.new
    m.title = params.fetch("the_title")
    m.year = params.fetch("the_year")
    m.duration = params.fetch("the_duration")
    m.description = params.fetch("the_description")
    m.image = params.fetch("the_image")
    m.director_id = params.fetch("the_director_id")

    m.save

    redirect_to("/directors")
    #retrieve the user's inputs from params
    #create a record in the movie table
    #populate each column with the user input
    # save

    #redirect the user back to the /movies URL
  end

  def destroy
      the_id = params.fetch("an_id")
      matching_records = Director.where({ :id => the_id })
      the_director=matching_records.at(0)
      the_director.destroy
      redirect_to("/directors")
  end
  
  
  def index
    matching_directors = Director.all
    @list_of_directors = matching_directors.order({ :created_at => :desc })

    render({ :template => "director_templates/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_directors = Director.where({ :id => the_id })
    @the_director = matching_directors.at(0)

    render({ :template => "director_templates/show" })
  end

  def max_dob
    directors_by_dob_desc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :desc })

    @youngest = directors_by_dob_desc.at(0)

    render({ :template => "director_templates/youngest" })
  end

  def min_dob
    directors_by_dob_asc = Director.
      all.
      where.not({ :dob => nil }).
      order({ :dob => :asc })
      
    @eldest = directors_by_dob_asc.at(0)

    render({ :template => "director_templates/eldest" })
  end
end
