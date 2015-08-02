# Redbubble

## Description
This application is completed as a task following this [brief](BRIEF.md).
The result is a script to process an input file of 'works' and output to html files following a particular format

## Assumptions
* Although the output template file was provided, it was only used as reference for the new file that was generated using ERB templating language syntax
* When a work is missing either a model or make, the application would skip this record as it does not make sense in the context of this application where we are showing works grouped by make and model
* Due to how we slugify and generate the url paths, we assume there are no conflicting model or makes when the name is transformed to slug form i.e. spaces to dash and lowercase.
* The outputted HTML uses the absolute path of the file as we assume the file to be only accessed through local file system.
* Only the image url labelled "small" is chosen to be the thumbnail for the work.
* It has not been designed for scale in mind thus it may not handle processing extremely large datasets.

## Requirements
Though Ruby on most desktop platforms should behave the same, it may be worth noting that the application was developed on Mac OS X 10.10.3 and tested using Ruby 2.2.1
The application is compatible with the following versions.

    Ruby >= 2.0

To check your version run:

    $ ruby -v

## Installation
To install the prerequisites from command line, invoke

    $ bundle install

## Running script
The application is designed to accept a number of command line arguments but the 'input' parameter is required

    $ rake run input=FILENAME

### Additional arguments
* `template=FILENAME` ERB template file to be used in place of default
* `output_dir=PATH` Output directory that will serve as base directory for generated files, defaults to "../output"

This information can also be accessed by the following

    $ rake -D

## Testing

Navigate to the repo directory and run

    $ rake spec
