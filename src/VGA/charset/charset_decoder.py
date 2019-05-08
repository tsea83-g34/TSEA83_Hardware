# -*- coding: utf-8 -*-

def constants(text, filename):
  i = text.index(filename + "_width")
  width = text[i:].split("\n")[0].split(" ")[1]
  
  i = text.index(filename + "_height")
  height = text[i:].split("\n")[0].split(" ")[1]
  
  return int(width), int(height)

def strip(text):
  start = text.index("{")
  end   = text.index("}")
  
  text = text[start:end]
  lines = text.split("\n")
  
  for line in lines:
    line = line.strip()
  
  raw_chunks = []
  # Skip first empty line
  for line in lines[1:]:
    raw_chunks += line[:-1].split(",")
    
  chunks = []
  for chunk in raw_chunks:
    chunks.append(chunk.strip()[2:])
  
  return chunks
  
def charify(chunks, width, size):
  char_num = width / size
  chars = ["" for x in range(char_num)]
  
  for char_i in range(char_num):
  
    for row in range(size):
      i = char_i * 2 + char_num * row * 2
      bin_string = bin(int(chunks[i + 1] + chunks[i], 16))[2:].zfill(16)[::-1]
      chars[char_i] += bin_string
  
  return chars

if __name__ == "__main__":
  
  filename = "charset"
  
  # File of singel height square characters
  with open(filename + ".bitmap") as f:
    text = f.read()
  
  width, size = constants(text, filename)
  clean = strip(text)
  
  chars = charify(clean, width, size)

  for index, char in enumerate(chars):
    print index
    
    bin_rows = [char[i:i + size] for i in range(0, len(char), size)]
  
    for row in bin_rows:
      print "".join(["█" if x == '1' else " " for x in row])
    print ""
  
  
  
  
  
  
  
  
  
  
