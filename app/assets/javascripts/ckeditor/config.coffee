CKEDITOR.editorConfig = (config) ->
  config.language = 'en'

  config.toolbar_mini = [ [
    'Bold'
    'Italic'
    'Underline'
    'Strike'
    '-'
    'NumberedList'
    'BulletedList'
    '-'
    'RemoveFormat'
  ] ]
  config.toolbar = 'mini'
