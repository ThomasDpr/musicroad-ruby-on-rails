// Connects to data-controller="map"
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Object,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/outdoors-v12",
    })

    if (this.markersValue.length === 0) {
      this.#addMarkerToMap()
      this.#fitMapToMarker()
    } else {
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
    }

  }

  #addMarkerToMap() {
      new mapboxgl.Marker()
        .setLngLat([ this.markerValue.lng, this.markerValue.lat ])
        .addTo(this.map)
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    })
  }

  #fitMapToMarker() {
    const bound =  new mapboxgl.LngLatBounds()
    bound.extend([ this.markerValue.lng, this.markerValue.lat ])
    this.map.fitBounds(bound, { padding: 70, maxZoom: 12, duration: 5000 })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 12, duration: 5000 })
  }
}