require 'tempfile'
require 'RMagick'
#require 'mini_magick'

module SoundmapHelper
  Pi = Math.acos(0)*2

  def add_arrays(x, y)
    res = []
    x.zip(y).each do |a,b|
      res << a+b
    end
    return res
  end

  def sub_arrays(x, y)
    res = []
    x.zip(y).each do |a,b|
      res << a-b
    end
    return res
  end


  def filled_arc(center, p1, p2, r, opts={color:"#000000"})
    p2 = sub_arrays(p2, p1)
    '<path d="M%f,%f l%f,%f a%f,%f 0 0,1 %f,%f z" style="stroke: %s; fill: %s; stroke-width: %s;" />' % (center + p1 + [r,r] + p2 + [opts[:color], opts[:color], 0.4])
  end

  def filled_arc_angle(center, a1, a2, r, opts={color:"#000000"})
    p1 = [r * Math.cos(a1), r * Math.sin(a1)]
    p2 = [r * Math.cos(a2), r * Math.sin(a2)]
    filled_arc(center, p1, p2, r, opts)
  end




  def generate_svg(numbers, mood_color,
                   opts={
                     width: 500, height: 500, mood_circle_width: 40, start_angle: 0,
                     # colorblind color palette, looks nice =D
                     # from http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/
                     colors: ["#E69F00", "#56B4E9", "#009E73", "#F0E442",
                              "#0072B2", "#D55E00", "#CC79A7", "#999999"]
                   })
    width = opts[:width]
    height = opts[:height]
    mood_circle_width = opts[:mood_circle_width]
    start_angle = opts[:start_angle]
    colors = opts[:colors]

    center = [(width/2), (height/2)]
    scale = 200/500.0 * [width, height].min

    out = ""
    out << '<svg xmlns="http://www.w3.org/2000/svg" xmlns:xlink="http://www.w3.org/1999/xlink" width="%f" height="%f">' % [width, height]
    out << "\n"

    out << '<rect x="0" y="0" width="%f" height="%f" fill="#333333" />' % [width, height]
    out << "\n"

    (1..4).each do |r|
      out << '<circle cx="%f" cy="%f" r="%f" stroke="%s" stroke-width="%f" fill="none" />' % (center + [scale*r/5, "#aaaaaa", 0.7])
      out << "\n"
    end

    n = numbers.length
    angle_diff = 2*Pi / n

    numbers.zip(colors) do |r, col|
      a1 = start_angle
      a2 = start_angle + angle_diff
      middle_a = (a1+a2)/2
      p = [scale*Math.cos(middle_a), scale*Math.sin(middle_a)]
      p = add_arrays(p, center)
      out << '<line x1="%f" y1="%f" x2="%f" y2="%f" stroke="%s" stroke-width="%f" />' % (center + p + ["#aaaaaa", 1] )
      out << "\n"
      out << filled_arc_angle(center, a1, a2, r*scale+1, color: col)
      out << "\n"
      start_angle += angle_diff
    end

    out << '<circle cx="%f" cy="%f" r="%f" stroke="%s" stroke-width="%f" fill="none" />' % (center + [scale + mood_circle_width/2, mood_color, mood_circle_width])
    out << "\n"

    out << "</svg>\n"

    return out
  end

  def svg_to_png(svg_blob)
    #file = file_from_blob(svg_blob, original_filename: 'image.svg', content_type: 'image/svg')
    # file = Tempfile.new(['image', '.svg'])
    # file.write svg_blob
    # file.rewind
    image = Magick::Image.from_blob(svg_blob) { self.format = "SVG" }[0]
    #image = MiniMagick::Image.open(file.path, "svg")
    #image = images[0]
    image.format = "PNG"
    image.to_blob
  end

  def file_from_blob(blob, opts={original_filename: 'image.png', content_type: "image/png" } )
    file = StringIO.new(blob)

    original_filename = opts[:original_filename]
    content_type = opts[:content_type]

    metaclass = class << file; self; end
    metaclass.class_eval do
      define_method(:original_filename) { original_filename }
      define_method(:content_type) { content_type }
    end

    return file
  end

  def temp_png(png_blob)
    file_from_blob(png_blob, original_filename: 'soundmap.png', content_type: 'image/png')
  end

  def generate_soundmap(numbers, mood_color,
                        opts={})
    default_opts = { width: 500, height: 500, mood_circle_width: 40, start_angle: 0,
      filetype: "png",
      # colorblind color palette, looks nice =D
      # from http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/
      colors: ["#E69F00", "#56B4E9", "#009E73", "#F0E442",
               "#0072B2", "#D55E00", "#CC79A7", "#999999"]
    }
    opts = default_opts.merge(opts)
    svg_blob = generate_svg(numbers, mood_color, opts)

    if opts[:filetype] == "png"
      png_blob = svg_to_png(svg_blob)
      return temp_png(png_blob)
    else
      return file_from_blob(svg_blob, original_filename: 'soundmap.svg', content_type: 'image/svg')
    end
  end

  # HSV values in [0..1]
  # returns HTML [r, g, b] values (e.g. #ff0324)
  def hsv_to_rgb(h, s, v)
    hp = h*6
    h_i = hp.to_i
    c = v * s
    x = c * (1-(hp % 2 - 1).abs)

    r, g, b = c, x, 0 if h_i==0
    r, g, b = x, c, 0 if h_i==1
    r, g, b = 0, c, x if h_i==2
    r, g, b = 0, x, c if h_i==3
    r, g, b = x, 0, c if h_i==4
    r, g, b = c, 0, x if h_i==5

    m = v - c

    s = [r+m,g+m,b+m].map{|c| "%02X" % (c*255).to_i}.join
    return '#'+s
  end

end
