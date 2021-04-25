-keepattributes *Annotation*, InnerClasses
-dontnote kotlinx.serialization.AnnotationsKt # core serialization annotations
#noinspection ShrinkerUnresolvedReference
# kotlinx-serialization-json specific. Add this if you have java.lang.NoClassDefFoundError kotlinx.serialization.json.JsonObjectSerializer
-keepclassmembers class kotlinx.serialization.json.** {
    *** Companion;
}
-keepclasseswithmembers class kotlinx.serialization.json.** {
    kotlinx.serialization.KSerializer serializer(...);
}

#com.hmelihf.kotlintest
-keep,includedescriptorclasses class com.hmelihf.kotlintest.**$$serializer { *; }
-keepclassmembers class com.hmelihf.kotlintest.** {
    *** Companion;
}
-keepclasseswithmembers class com.hmelihf.kotlintest.** {
    kotlinx.serialization.KSerializer serializer(...);
}