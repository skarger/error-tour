(defn example1 []
   (println "example 1:")
   (let [value (get [1 2 3] 5)]
     (print "Value: ")
     (println value)))
   
   
(defn example2 []
   (println "example 2:")
   (try
      (aget (int-array [1 2 3]) 5)
      (catch Exception e (println (str "caught exception: " (.toString e))))
      (finally (println "This is our final block"))))   
   
(example1)
(example2)



$java -jar /usr/share/java/clojure.jar -i main.clj
example 1:
Value: nil
example 2:
caught exception: java.lang.ArrayIndexOutOfBoundsException: 5
This is our final block


