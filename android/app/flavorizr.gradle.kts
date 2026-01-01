import com.android.build.gradle.AppExtension

val android = project.extensions.getByType(AppExtension::class.java)

android.apply {
    flavorDimensions("flavor-type")

    productFlavors {
        create("dev") {
            dimension = "flavor-type"
            applicationId = "id.flashlight.dev"
            resValue(type = "string", name = "app_name", value = "Flashlight POS Dev")
        }
        create("staging") {
            dimension = "flavor-type"
            applicationId = "id.flashlight.qa"
            resValue(type = "string", name = "app_name", value = "Flashlight POS Staging")
        }
        create("production") {
            dimension = "flavor-type"
            applicationId = "id.flashlight"
            resValue(type = "string", name = "app_name", value = "Flashlight POS")
        }
    }
}