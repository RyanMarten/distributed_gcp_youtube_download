from rowans_utils import * 

# pip install numpy lxml
if __name__ == "__main__":
  output = read_vtt("----meyKR48.en.vtt")
  with open("PARSED_----meyKR48.en.vtt", "w") as f:
    for word, start, stop in output:
      f.write(f"{word} {start} {stop}")