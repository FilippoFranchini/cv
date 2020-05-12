# Take entire positions dataframe and removes the links
# in descending order so links for the same position are
# right next to eachother in number.
strip_links_from_cols <- function(data, cols_to_strip){
  for(i in 1:nrow(data)){
    for(col in cols_to_strip){
      data[i, col] <- data[i, col]
    }
  }
  data
}

# Take a position dataframe and the section id desired
# and prints the section to markdown.
print_section <- function(position_data, section_id){
    
    position_data %>%
    filter(section == section_id) %>%
    arrange(desc(end)) %>%
    mutate(id = 1:n()) %>%
    pivot_longer(
      starts_with('description'),
      names_to = 'description_num',
      values_to = 'description'
    ) %>%
    filter(!is.na(description) | description_num == 'description_1') %>%
    group_by(id) %>%
    mutate(
      descriptions = list(description),
      no_descriptions = is.na(first(description))
    ) %>%
    ungroup() %>%
    filter(description_num == 'description_1') %>%
    mutate(
      timeline = ifelse(
        is.na(end) | start == end,
        start,
        glue('{end} - {start}')
      ),
      description_bullets = ifelse(
        no_descriptions,
        ' ',
        map_chr(descriptions, ~paste('-', ., collapse = '\n'))
      )
    ) %>%
    strip_links_from_cols(c('title', 'description_bullets')) %>%
    mutate_all(~ifelse(is.na(.), 'N/A', .)) %>%
    when(section_id == "awards" | section_id == "interests" ~ glue_data(.,"{title}","\n\n"), 
         ~glue_data(.,"### {title}","\n\n","{institution}","\n\n",
                    "{loc}","\n\n","{timeline}","\n\n","{description_bullets}","\n\n\n"))

}

# Construct a bar chart of skills
build_skill_bars <- function(skills, out_of = 5){
  bar_color <- "#969696"
  bar_background <- "#d9d9d9"
  skills %>%
    mutate(width_percent = round(100*level/out_of)) %>%
    glue_data(
      "<div class = 'skill-bar'",
      "style = \"background:linear-gradient(to right,",
      "{bar_color} {width_percent}%,",
      "{bar_background} {width_percent}% 100%)\" >",
      "{skill}",
      "</div>"
    )
}

# Prints out from text_blocks spreadsheet blocks of text for the intro and asides.
print_text_block <- function(text_blocks, label){
  filter(text_blocks, loc == label)$text %>%
    cat()
}
