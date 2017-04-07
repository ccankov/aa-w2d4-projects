def string_perms(str)
  return [str] if str.length == 1
  chars = str.split("")
  anagrams = []

  chars.each_with_index do |ch, id|
    perms = chars.reject{|val| chars[id] == val}
    anagrams.concat(string_perms(perms.join).map{|perm| ch + perm})
  end
  anagrams
end

def first_anagram?(str, target)
  string_perms(str).include?(target)
end

p first_anagram?("elvis", "lives")

def second_anagram?(str, target)
  str_arr = str.chars
  tar_arr = target.chars

  str.chars.each do |ch|
    str_arr.delete_at(str_arr.index(ch))
    tar_arr.delete_at(tar_arr.index(ch))
  end
  str_arr.empty? && tar_arr.empty?
end

p second_anagram?("elvis", "lives")

def third_anagram?(str, tar)
  str.chars.sort == tar.chars.sort
end

p third_anagram?("elvis", "lives")

def fourth_anagram?(str, tar)
  ltrs = Hash.new(0)
  str.chars.each {|ltr| ltrs[ltr] += 1}
  tar.chars.each {|ltr| ltrs[ltr] -= 1}
  ltrs.values.all?{|k| k == 0}
end

p fourth_anagram?("elvis", "lives")
