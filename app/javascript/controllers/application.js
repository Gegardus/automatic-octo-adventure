import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-webpack-helpers"
import Carousel from 'stimulus-carousel'

const context = require.context("./", true, /\.js$/)
const application = Application.start()

application.register('carousel', Carousel)

window.Stimulus = application

Stimulus.load(definitionsFromContext(context))
