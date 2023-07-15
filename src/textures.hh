#pragma once
#include <string>

class Texture {
private:
  unsigned int t_render_id;
  std::string t_filepath;
  unsigned char *t_localbuffer;
  int t_width, t_height, t_bpp;

public:
  Texture(const std::string &file);
  ~Texture();

  void bind(unsigned int slot = 0) const;
  void unbind() const;

  inline int get_width() const { return t_width; };
  inline int get_height() const { return t_height; };
};
