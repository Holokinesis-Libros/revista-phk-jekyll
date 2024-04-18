require 'find'
require 'debug'

INP_DIR = 'pdf'
OUT_DIR = 'indices'


def pdf_mark(title, page)
  "[ /Page #{page} /Title (#{title}) /OUT pdfmark\n"
end

def md_link(title, page, pdf_file)
  "- [#{title}](/#{pdf_file}#page=#{page})\n"
end

def metadata(title, author, subject, keywords)
  "[/Title (#{title}) /Author (#{author}) /Subject (#{subject}) /Keywords (#{keywords}) /DOCINFO pdfmark\n"
end


def find_pdf_files(in_dir, out_dir)
  Find.find(in_dir) do | inp_file_pdf |
    ext = File.extname(inp_file_pdf)
    fname = File.basename(inp_file_pdf, ext)
    if ext.downcase == ".pdf"
      out_file_txt = File.join(OUT_DIR, fname) + ".txt"
      out_file_pdf = File.join(OUT_DIR, fname) + ".pdf"
      out_file_md = File.join(OUT_DIR, fname) + ".md"
      system "pdftotext -f 3 -l 3 #{inp_file_pdf} tmp.txt"
      File.open('tmp.txt', 'r') do |file|
        outline_pdf = metadata "Revista oficial de Psicología Holokinética", "Academia Internacional de Psicología Holokinética", "Psicologia Holokinetica", "psicologia, ruben feldman gonzalez, holokinesis"
        outline_pdf << pdf_mark("Portada", 1)
        outline_md = ""
        outline_md << md_link("Portada", 1, inp_file_pdf)
        page = 0
        title = ""
        file.each_line do |line|
          # Special case for indice
          line = line.strip
          if line == "ÍNDICE"
            outline_pdf << pdf_mark(line, 3)
            outline_md << md_link(line, 3, inp_file_pdf)
            title =""
            next
          end

          # Discard empty lines
          if line == ""
            next
          end

          # If it's a number? time to put the pdf mark
          if line.match(/^\d+$/)
            page = line.to_i + 3
            title = title.gsub("\n", ' ').squeeze(' ')
            outline_pdf << pdf_mark(title, page)
            outline_md << md_link(title, page, inp_file_pdf)
            title = ""
            next
          end


          # Join text lines with space
          if title != ""
            title << " "
          end
          title << line
        end
        outline_pdf = outline_pdf.gsub "Feldman­González", "Feldman González"
        outline_md = outline_md.gsub "Feldman­González", "Feldman González"
        File.write(out_file_txt, outline_pdf)
        File.write(out_file_md, outline_md)
        system "gs -dBATCH -dNOPAUSE -sDEVICE=pdfwrite -sOutputFile=#{out_file_pdf} #{inp_file_pdf} #{out_file_txt}"

      end
    end
  end
end

find_pdf_files(INP_DIR, OUT_DIR) # replace with the actual directory inp_file_pdf
