allprojects {
    repositories {
        google()
        mavenCentral()
        maven { url =uri("https://jitpack.io") } 
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)
subprojects {
    afterEvaluate {
        extensions.findByName("android")?.let {
            it as com.android.build.gradle.BaseExtension
            it.ndkVersion = "29.0.14206865"
        }
    }
}
subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
