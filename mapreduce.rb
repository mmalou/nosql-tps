#map = function() {
#  emit(this.gender, 1);
#};
#
#reduce = function(key, values) {
#  return Array.sum(values);
#};
#
#db.characters.mapReduce(map, reduce, {
#    out: "gender_count_al"
#});
