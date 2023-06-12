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
      // style: "mapbox://styles/mapbox/outdoors-v12",
      style: 'mapbox://styles/mapbox/satellite-streets-v11',
    })

    this.map.dragPan.disable();
    this.map.scrollZoom.disable();
    this.map.doubleClickZoom.disable();
    this.map.boxZoom.disable();


    if (this.markersValue.length === 0) {
      this.#addMarkerToMap()
      this.#fitMapToMarker()
    } else {
      this.#addMarkersToMap()
      this.#fitMapToMarkers()
    }

  }

  #addMarkerToMap() {
    const popup = new mapboxgl.Popup().setHTML(this.markerValue.info_window_html)
    new mapboxgl.Marker()
      .setLngLat([ this.markerValue.lng, this.markerValue.lat ])
      .addTo(this.map)
      .setPopup(popup)
  }

  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
        .setPopup(popup)
    })
  }

  #fitMapToMarker() {
    const bound =  new mapboxgl.LngLatBounds()
    bound.extend([ this.markerValue.lng, this.markerValue.lat ])
    this.map.fitBounds(bound, { padding: 70, maxZoom: 10, duration: 0 })
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 70, maxZoom: 10, duration:0 })
  }
}
